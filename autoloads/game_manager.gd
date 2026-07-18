# game_manager.gd
extends Node

enum CoinType {BLUE, GREEN, YELLOW, RED}
enum BuildingType {NONE, WAREHOUSE, WINDMILL, LUMBER, BLACKSMITH, CASTLE, CAMP}

@export var blue_amount: float = 0
@export var green_amount: float = 0
@export var yellow_amount: float = 0
@export var red_amount: float = 0
@export var coin_cap: float = 1000

var blue_production: int = 0
var green_production: int = 0
var yellow_production: int = 0
var red_production: int = 0

var in_build_mode: bool = false
var selected_building: BuildingType = BuildingType.NONE

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)

func _on_coin_update(amount: int, type: CoinType) -> void:
	match type:
		CoinType.BLUE:
			if blue_amount + amount <= coin_cap:
				blue_amount += amount

		CoinType.GREEN:
			if green_amount + amount <= coin_cap:
				green_amount += amount

		CoinType.YELLOW:
			if yellow_amount + amount <= coin_cap:
				yellow_amount += amount

		CoinType.RED:
			if red_amount + amount <= coin_cap:
				red_amount += amount
		_:
			return

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_build_mode"):
		in_build_mode = false
		print("exit building")

	if in_build_mode:
		if Input.is_action_just_pressed("place_building"):
			EventBus.OnPlaceBuilding.emit(selected_building)

	if Input.is_action_just_pressed("open_menu"):
		print("open menu")

func update_coin_cap(new_cap: int) -> void:
	coin_cap = new_cap
	EventBus.OnUpdateCoinCap.emit()
