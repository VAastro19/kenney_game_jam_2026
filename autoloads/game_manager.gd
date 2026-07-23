# game_manager.gd
extends Node

enum CoinType {BLUE, GREEN, YELLOW, RED}
enum BuildingType {NONE, WAREHOUSE, WINDMILL, LUMBER, BLACKSMITH, CASTLE, CAMP, MONUMENT}

@export var coin_cap: float = 1000
@export var blue_amount: float = 0
@export var green_amount: float = 0
@export var yellow_amount: float = 0
@export var red_amount: float = 0

@export var blue_efficiency: float = 1.0
@export var green_efficiency: float = 1.0
@export var yellow_efficiency: float = 1.0
@export var red_efficiency: float = 1.0

@export var blue_time: float = 1.0
@export var green_time: float = 2.0
@export var yellow_time: float = 3.0
@export var red_time: float = 5.0

var blue_generators: int = 0
var green_generators: int = 0
var yellow_generators: int = 0
var red_generators: int = 0
var warehouses: int = 0

var warehouse_cost: float:
	get:
		return floor(10 * (warehouses ** 2 + 5.0))
var windmill_cost: float:
	get:
		return floor(10 * (blue_generators ** 2 + 5.0))
var lumber_cost: float:
	get:
		return floor(10 * (green_generators ** 2 + 10.0))
var blacksmith_cost: float:
	get:
		return floor(10 * (yellow_generators ** 2 + 10.0))
var castle_cost: float:
	get:
		return floor(10 * (red_generators ** 2 + 10.0))

var blue_production: float:
	get:
		return blue_generators * blue_efficiency / blue_time
var green_production: float = 0:
	get:
		return green_generators * green_efficiency / green_time
var yellow_production: float = 0:
	get:
		return yellow_generators * yellow_efficiency / yellow_time
var red_production: float = 0:
	get:
		return red_generators * red_efficiency / red_time

var in_build_mode: bool = false
var selected_building: BuildingType = BuildingType.NONE

func _ready() -> void:
	EventBus.OnClick.connect(_on_click)
	EventBus.OnTick.connect(_on_tick)

func _on_click(amount: float, type: CoinType) -> void:
	match type:
		CoinType.BLUE:
			if blue_amount + amount <= coin_cap:
				blue_amount += amount
				EventBus.OnUpdateCoin.emit(CoinType.BLUE)

		CoinType.GREEN:
			if green_amount + amount <= coin_cap:
				green_amount += amount
				EventBus.OnUpdateCoin.emit(CoinType.GREEN)

		CoinType.YELLOW:
			if yellow_amount + amount <= coin_cap:
				yellow_amount += amount
				EventBus.OnUpdateCoin.emit(CoinType.YELLOW)

		CoinType.RED:
			if red_amount + amount <= coin_cap:
				red_amount += amount
				EventBus.OnUpdateCoin.emit(CoinType.RED)
		_:
			return

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_build_mode"):
		in_build_mode = false

	if in_build_mode:
		if Input.is_action_just_pressed("place_building"):
			EventBus.OnPlaceBuilding.emit(selected_building)

func _on_tick() -> void:
	if blue_amount + blue_production <= coin_cap:
		blue_amount = min(coin_cap, blue_amount + blue_production)
		EventBus.OnUpdateCoin.emit(CoinType.BLUE)
	if green_amount + green_production <= coin_cap:
		green_amount = min(coin_cap, green_amount + green_production)
		EventBus.OnUpdateCoin.emit(CoinType.GREEN)
	if yellow_amount + yellow_production <= coin_cap:
		yellow_amount = min(coin_cap, yellow_amount + yellow_production)
		EventBus.OnUpdateCoin.emit(CoinType.YELLOW)
	if red_amount + red_production <= coin_cap:
		red_amount = min(coin_cap, red_amount + red_production)
		EventBus.OnUpdateCoin.emit(CoinType.RED)

func update_coin_cap() -> void:
	coin_cap *= 10
	EventBus.OnUpdateCoin.emit(CoinType.BLUE)
	EventBus.OnUpdateCoin.emit(CoinType.GREEN)
	EventBus.OnUpdateCoin.emit(CoinType.YELLOW)
	EventBus.OnUpdateCoin.emit(CoinType.RED)
