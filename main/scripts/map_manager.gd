# map_manager.gd
class_name MapManager extends Node2D

class HexInfo:
	var is_used: bool = false
	var hex_type: BuildManager.BuildingType = BuildManager.BuildingType.NONE

@onready var marker: Node2D = $TileMapLayer/HighlightMarker
@onready var hex_map: TileMapLayer = $TileMapLayer
var hex_info: Dictionary[Vector2i, HexInfo]
var hex_atlas_coords: Dictionary[BuildManager.BuildingType, Vector2i] = {
	BuildManager.BuildingType.WAREHOUSE: Vector2i(8, 1),
	BuildManager.BuildingType.WINDMILL: Vector2i(7, 4),
	BuildManager.BuildingType.LUMBER: Vector2i(5, 6),
	BuildManager.BuildingType.BLACKSMITH: Vector2i(8, 2),
	BuildManager.BuildingType.CASTLE: Vector2i(7, 11),
	BuildManager.BuildingType.CAMP: Vector2i(10, 7),
	BuildManager.BuildingType.MONUMENT: Vector2i(8, 0)
}

func _ready() -> void:
	EventBus.OnPlaceBuilding.connect(_try_set_hex_state)
	EventBus.OnMonumentBuilt.connect(_win_the_game)
	
	# Create a new HexInfo for each hex on our map
	for cell in hex_map.get_used_cells():
		hex_info[cell] = HexInfo.new()

	hex_info[Vector2i(-1,-1)].is_used = true
	hex_info[Vector2i(-1,-1)].hex_type = BuildManager.BuildingType.CAMP

func _process(_delta: float) -> void:
	if BuildManager.in_build_mode:
		marker.visible = true
		var coords: Vector2i = hex_map.local_to_map(get_local_mouse_position())
		marker.position = hex_map.map_to_local(coords)
	else:
		marker.visible = false

func _try_set_hex_state(building_type: BuildManager.BuildingType) -> void:
	var coords: Vector2i = hex_map.local_to_map(get_local_mouse_position())
	
	if hex_info[coords].is_used or BuildManager.in_build_mode == false:
		return
	if not BuildManager._check_building_cost(building_type):
		return
	else:
		hex_map.set_cell(coords, 0, hex_atlas_coords[building_type])
		hex_info[coords].is_used = true
		hex_info[coords].hex_type = building_type
		BuildManager._add_building(building_type)

# Cutscene after completing the game
func _win_the_game() -> void:
	var game_hud = $CanvasLayer/GameHUD
	var camera = $Camera2D
	
	camera.allow_pan = false
	
	# Fade out the HUD
	var tween_opacity: Tween = get_tree().create_tween()
	tween_opacity.tween_property(game_hud, "modulate:a", 0, 1.0).set_trans(Tween.TRANS_SINE)
	
	# Move camera to the central position
	var tween_camera: Tween = get_tree().create_tween()
	tween_camera.tween_property(camera, "position", Vector2(0,0), 1.5)
	
	# Wait for the tweens to finish their job
	await get_tree().create_timer(2.0).timeout
	
	# Change the camp tile to monument
	hex_info[Vector2i(-1,-1)].hex_type = EconomyManager.BuildingType.MONUMENT
	hex_map.set_cell(Vector2i(-1,-1), 0, hex_atlas_coords[EconomyManager.BuildingType.MONUMENT])
	
	# Load the main menu after a second
	await get_tree().create_timer(1.0).timeout
	SceneLoader.load_scene("uid://jlbgrqoqh5fq")

func _on_timer_timeout() -> void:
	print("TICK!")
	EventBus.OnTick.emit()
