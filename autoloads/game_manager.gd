# game_manager.gd
extends Node2D

enum CoinType {BLUE, GREEN, YELLOW, RED}

@export var blue_amount: int = 0
@export var green_amount: int = 0
@export var yellow_amount: int = 0
@export var red_amount: int = 0

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)

func _on_coin_update(amount: int, type: CoinType) -> void:
	match type:
		CoinType.BLUE:
			blue_amount += amount
		CoinType.GREEN:
			green_amount += amount
		CoinType.YELLOW:
			yellow_amount += amount
		CoinType.RED:
			red_amount += amount
		_:
			return
