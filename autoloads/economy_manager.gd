# economy_manager.gd
extends Node

enum CoinType {NONE, BLUE, GREEN, YELLOW, RED}

@export var coin_cap: float = 3000

@export var blue_amount: float = 3000
@export var green_amount: float = 3000
@export var yellow_amount: float = 0
@export var red_amount: float = 0

@export var blue_efficiency: float = 1.0
@export var green_efficiency: float = 1.0
@export var yellow_efficiency: float = 1.0
@export var red_efficiency: float = 1.0

var blue_generators: int = 0
var green_generators: int = 0
var yellow_generators: int = 0
var red_generators: int = 0
var warehouses: int = 0

## --- BUILDING COSTS --- ##
var warehouse_cost: float:
	get: return floor(10 * (warehouses ** 2 + 5.0))

var windmill_cost: float:
	get: return floor(10 * (blue_generators ** 2 + 5.0))

var lumber_cost: float:
	get: return floor(10 * (green_generators ** 2 + 10.0))

var blacksmith_cost: float:
	get: return floor(10 * (yellow_generators ** 2 + 10.0))

var castle_cost: float:
	get: return floor(10 * (red_generators ** 2 + 10.0))

## --- COIN PRODUCTION --- ##
var blue_production: float:
	get: return blue_generators * blue_efficiency

var green_production: float = 0:
	get: return green_generators * green_efficiency

var yellow_production: float = 0:
	get: return yellow_generators * yellow_efficiency

var red_production: float = 0:
	get: return red_generators * red_efficiency

## --- FUNCTIONS --- ##
func _ready() -> void:
	EventBus.OnClick.connect(_on_click)
	EventBus.OnTick.connect(_on_tick)

func _on_click(amount: float, type: CoinType) -> void:
	var coin_type_name: String = CoinType.keys()[type].to_lower()
	if get(coin_type_name + "_amount") + amount <= coin_cap:
		set(coin_type_name + "_amount", get(coin_type_name + "_amount") + amount)
		EventBus.OnUpdateCoin.emit(type)

func _on_tick() -> void:
	blue_amount = min(coin_cap, blue_amount + blue_production)
	EventBus.OnUpdateCoin.emit(CoinType.BLUE)

	green_amount = min(coin_cap, green_amount + green_production)
	EventBus.OnUpdateCoin.emit(CoinType.GREEN)

	yellow_amount = min(coin_cap, yellow_amount + yellow_production)
	EventBus.OnUpdateCoin.emit(CoinType.YELLOW)

	red_amount = min(coin_cap, red_amount + red_production)
	EventBus.OnUpdateCoin.emit(CoinType.RED)

func update_coin_cap() -> void:
	coin_cap *= 2
	EventBus.OnUpdateCoin.emit(CoinType.BLUE)
	EventBus.OnUpdateCoin.emit(CoinType.GREEN)
	EventBus.OnUpdateCoin.emit(CoinType.YELLOW)
	EventBus.OnUpdateCoin.emit(CoinType.RED)
