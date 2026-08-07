# coin_counter.gd
class_name CoinCounter extends Control

@onready var economy_manager: Node = %EconomyManager

@onready var coin_texture: TextureRect = $HBoxContainer/CoinIcon
@onready var amount_label: Label = $HBoxContainer/CoinCounterLabel

@export var coin_type: Enums.CoinType
var coin_type_name: String

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)
	
	match coin_type:
		Enums.CoinType.BLUE:
			coin_texture.texture = load("uid://c2pgc2wuco2a1")

		Enums.CoinType.GREEN:
			coin_texture.texture = load("uid://c0cxtfjfkdxag")

		Enums.CoinType.YELLOW:
			coin_texture.texture = load("uid://btpjfu7rn478t")

		Enums.CoinType.RED:
			coin_texture.texture = load("uid://dum12h5kdlrj4")
		
	coin_type_name = Enums.CoinType.keys()[coin_type].to_lower() + "_amount"

func _on_coin_update(type: Enums.CoinType) -> void:
	if type == coin_type:
		amount_label.text = str(int(economy_manager.get(coin_type_name))) + " / " + str(int(economy_manager.coin_cap))
