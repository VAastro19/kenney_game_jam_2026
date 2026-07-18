# map_manager.gd
class_name MapManager extends Node2D

class HexInfo:
	var is_used: bool = false
	var hex_type: GameManager.BuildingType = GameManager.BuildingType.NONE

@onready var marker: Node2D = $TileMapLayer/HighlightMarker
@onready var hex_map: TileMapLayer = $TileMapLayer
var hex_info: Dictionary[Vector2i, HexInfo]
var hex_atlas_coords: Dictionary[GameManager.BuildingType, Vector2i] = {
	GameManager.BuildingType.WAREHOUSE: Vector2i(8, 1),
	GameManager.BuildingType.WINDMILL: Vector2i(7, 4),
	GameManager.BuildingType.LUMBER: Vector2i(5, 6),
	GameManager.BuildingType.BLACKSMITH: Vector2i(8, 2),
	GameManager.BuildingType.CASTLE: Vector2i(7, 11),
	GameManager.BuildingType.CAMP: Vector2i(10, 7)
}

func _ready() -> void:
	EventBus.OnPlaceBuilding.connect(_try_set_hex_state)
	
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
	else:
		hex_map.set_cell(coords, 0, hex_atlas_coords[building_type])
		hex_info[coords].is_used = true
