# map_manager.gd
class_name MapManager extends Node2D

class HexInfo:
	var is_used: bool = false
	var hex_type: GameManager.BuildingType = GameManager.BuildingType.NONE

@onready var build_audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var marker: Node2D = $TileMapLayer/HighlightMarker
@onready var hex_map: TileMapLayer = $TileMapLayer
var hex_info: Dictionary[Vector2i, HexInfo]
var hex_atlas_coords: Dictionary[GameManager.BuildingType, Vector2i] = {
	GameManager.BuildingType.WAREHOUSE: Vector2i(8, 1),
	GameManager.BuildingType.WINDMILL: Vector2i(7, 4),
	GameManager.BuildingType.LUMBER: Vector2i(5, 6),
	GameManager.BuildingType.BLACKSMITH: Vector2i(8, 2),
	GameManager.BuildingType.CASTLE: Vector2i(7, 11),
	GameManager.BuildingType.CAMP: Vector2i(10, 7),
	GameManager.BuildingType.MONUMENT: Vector2i(8, 0)
}

func _ready() -> void:
	EventBus.OnPlaceBuilding.connect(_try_set_hex_state)
	EventBus.OnMonumentBuilt.connect(_win_the_game)
	
	# Create a new HexInfo for each hex on our map
	for cell in hex_map.get_used_cells():
		hex_info[cell] = HexInfo.new()

	hex_info[Vector2i(-1,-1)].is_used = true
	hex_info[Vector2i(-1,-1)].hex_type = GameManager.BuildingType.CAMP

func _process(_delta: float) -> void:
	if GameManager.in_build_mode:
		marker.visible = true
		var coords: Vector2i = hex_map.local_to_map(get_local_mouse_position())
		marker.position = hex_map.map_to_local(coords)
	else:
		marker.visible = false

func _try_set_hex_state(building_type: GameManager.BuildingType) -> void:
	var coords: Vector2i = hex_map.local_to_map(get_local_mouse_position())
	
	if hex_info[coords].is_used or GameManager.in_build_mode == false:
		return
	if not _check_building_cost(building_type):
		return
	else:
		hex_map.set_cell(coords, 0, hex_atlas_coords[building_type])
		hex_info[coords].is_used = true
		hex_info[coords].hex_type = building_type
		_add_building(building_type)

func _check_building_cost(building_type: GameManager.BuildingType) -> bool:
	match building_type:
		GameManager.BuildingType.WINDMILL:
			if GameManager.windmill_cost <= GameManager.blue_amount:
				GameManager.blue_amount -= GameManager.windmill_cost
				return true
			else:
				print("Not enough blue coins!")
				print(GameManager.blue_amount)
				print(GameManager.windmill_cost)
				return false

		GameManager.BuildingType.LUMBER:
			if GameManager.lumber_cost <= GameManager.blue_amount:
				GameManager.blue_amount -= GameManager.lumber_cost
				return true
			else:
				print("Not enough blue coins!")
				return false

		GameManager.BuildingType.BLACKSMITH:
			if GameManager.blacksmith_cost <= GameManager.green_amount:
				GameManager.green_amount -= GameManager.blacksmith_cost
				return true
			else:
				print("Not enough green coins!")
				return false

		GameManager.BuildingType.CASTLE:
			if GameManager.castle_cost <= GameManager.yellow_amount:
				GameManager.yellow_amount -= GameManager.castle_cost
				return true
			else:
				print("Not enough yellow coins!")
				return false

		GameManager.BuildingType.WAREHOUSE:
			if GameManager.warehouse_cost <= GameManager.green_amount:
				GameManager.green_amount -= GameManager.warehouse_cost
				return true
			else:
				print("Not enough green coins!")
				return false
		
		_:
			print("Unknown building")
			return false

func _add_building(building_type: GameManager.BuildingType) -> void:
	match building_type:
		GameManager.BuildingType.WINDMILL:
			GameManager.blue_generators += 1

		GameManager.BuildingType.LUMBER:
			GameManager.green_generators += 1

		GameManager.BuildingType.BLACKSMITH:
			GameManager.yellow_generators += 1

		GameManager.BuildingType.CASTLE:
			GameManager.red_generators += 1

		GameManager.BuildingType.WAREHOUSE:
			GameManager.warehouses += 1
			GameManager.update_coin_cap()

		_:
			pass
	
	build_audio.play()
	await get_tree().create_timer(0.3).timeout
	build_audio.play()

func _on_timer_timeout() -> void:
	print("TICK!")
	EventBus.OnTick.emit()

func _win_the_game() -> void:
	var game_ui = $CanvasLayer/GameUI
	var camera = $Camera2D
	
	camera.allow_pan = false
	
	var tween_opacity: Tween = get_tree().create_tween()
	tween_opacity.tween_property(game_ui, "modulate:a", 0, 1.0).set_trans(Tween.TRANS_SINE)
	
	var tween_camera: Tween = get_tree().create_tween()
	tween_camera.tween_property(camera, "position", Vector2(0,0), 1.5)
	
	await get_tree().create_timer(2.0).timeout
	
	hex_info[Vector2i(-1,-1)].hex_type = GameManager.BuildingType.MONUMENT
	hex_map.set_cell(Vector2i(-1,-1), 0, hex_atlas_coords[GameManager.BuildingType.MONUMENT])
	
	await get_tree().create_timer(1.0).timeout
	SceneLoader.load_scene("uid://jlbgrqoqh5fq")
