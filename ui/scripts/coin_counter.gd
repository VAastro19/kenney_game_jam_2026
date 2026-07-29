# coin_counter.gd
class_name CoinCounter extends Control

@onready var coin_texture: TextureRect = $HBoxContainer/CoinIcon
@onready var amount_label: Label = $HBoxContainer/CoinCounterLabel

@export var coin_type: EconomyManager.CoinType
var coin_type_name: String

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)
	
	match coin_type:
		EconomyManager.CoinType.BLUE:
			coin_texture.texture = load("uid://c2pgc2wuco2a1")

		EconomyManager.CoinType.GREEN:
			coin_texture.texture = load("uid://c0cxtfjfkdxag")

		EconomyManager.CoinType.YELLOW:
			coin_texture.texture = load("uid://btpjfu7rn478t")

		EconomyManager.CoinType.RED:
			coin_texture.texture = load("uid://dum12h5kdlrj4")
		
	coin_type_name = EconomyManager.CoinType.keys()[coin_type].to_lower() + "_amount"

func _on_coin_update(type: EconomyManager.CoinType) -> void:
	if type == coin_type:
		amount_label.text = str(int(EconomyManager.get(coin_type_name))) + " / " + str(int(EconomyManager.coin_cap))
