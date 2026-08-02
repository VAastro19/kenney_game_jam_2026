# economy_manager.gd
extends Node

enum CoinType {NONE, BLUE, GREEN, YELLOW, RED}

@export var coin_cap: float = 500
@export var efficiency_increase: float = 1.5

# Coin amounts
@export var blue_amount: float = 0
@export var green_amount: float = 0
@export var yellow_amount: float = 0
@export var red_amount: float = 0

# Coin production efficiency
var blue_efficiency: float:
	get: return calculate_efficiency(windmill_eff_count)
var green_efficiency: float:
	get: return calculate_efficiency(lumber_eff_count)
var yellow_efficiency: float:
	get: return calculate_efficiency(blacksmith_eff_count)
var red_efficiency: float:
	get: return calculate_efficiency(castle_eff_count)

# Count of placed buildings
var blue_generators: int = 0
var green_generators: int = 0
var yellow_generators: int = 0
var red_generators: int = 0
var warehouses: int = 0

# Count of bought upgrades
var click_value_count: int = 0
var windmill_eff_count: int = 0
var lumber_eff_count: int = 0
var blacksmith_eff_count: int = 0
var castle_eff_count: int = 0

## --- MONUMENT COST --- ##
var monument_cost: float = 100000

## --- BUILDING COSTS --- ##
var warehouse_cost: float:
	get: return calculate_building_cost(10, warehouses, 5.0)

var windmill_cost: float:
	get: return calculate_building_cost(10, blue_generators, 5.0)

var lumber_cost: float:
	get: return calculate_building_cost(10, green_generators, 10.0)

var blacksmith_cost: float:
	get: return calculate_building_cost(10, yellow_generators, 15.0)

var castle_cost: float:
	get: return calculate_building_cost(10, red_generators, 20.0)

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
	else:
		set(coin_type_name + "_amount", coin_cap)

func _on_tick() -> void:
	print(blue_production)
	print(blue_efficiency)
	blue_amount = min(coin_cap, blue_amount + blue_production)
	EventBus.OnUpdateCoin.emit(CoinType.BLUE)

	green_amount = min(coin_cap, green_amount + green_production)
	EventBus.OnUpdateCoin.emit(CoinType.GREEN)

	yellow_amount = min(coin_cap, yellow_amount + yellow_production)
	EventBus.OnUpdateCoin.emit(CoinType.YELLOW)

	red_amount = min(coin_cap, red_amount + red_production)
	EventBus.OnUpdateCoin.emit(CoinType.RED)

## Calculates exponential cost increase based on three parameters
func calculate_building_cost(multiplier: float, building_count: int, initial_offset: float) -> float:
	return floor(multiplier * (building_count ** 2 + initial_offset))

func calculate_upgrade_cost(multiplier: float, upgrade_count: int, initial_offset: float) -> float:
	return floor(multiplier * (upgrade_count ** 3 + initial_offset))

func calculate_efficiency(item_count: int) -> float:
	return max(1.0, efficiency_increase ** item_count)

func update_coin_cap() -> void:
	coin_cap *= 2
	EventBus.OnUpdateCoin.emit(CoinType.BLUE)
	EventBus.OnUpdateCoin.emit(CoinType.GREEN)
	EventBus.OnUpdateCoin.emit(CoinType.YELLOW)
	EventBus.OnUpdateCoin.emit(CoinType.RED)
