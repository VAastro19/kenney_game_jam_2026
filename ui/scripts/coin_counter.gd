# coin_counter.gd
class_name CoinCounter extends Control

@onready var coin_texture: TextureRect = $HBoxContainer/CoinIcon
@onready var amount_label: Label = $HBoxContainer/CoinCounterLabel

@export var coin_type: GameManager.CoinType

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)
	
	match coin_type:
		GameManager.CoinType.BLUE:
			coin_texture.texture = load("uid://c2pgc2wuco2a1")

		GameManager.CoinType.GREEN:
			coin_texture.texture = load("uid://c0cxtfjfkdxag")

		GameManager.CoinType.YELLOW:
			coin_texture.texture = load("uid://btpjfu7rn478t")

		GameManager.CoinType.RED:
			coin_texture.texture = load("uid://dum12h5kdlrj4")

func _on_coin_update(type: GameManager.CoinType) -> void:
	if type == coin_type:
		match coin_type:
			GameManager.CoinType.BLUE:
				amount_label.text = str(GameManager.blue_amount) + " / " + str(GameManager.coin_cap)

			GameManager.CoinType.GREEN:
				amount_label.text = str(GameManager.green_amount) + " / " + str(GameManager.coin_cap)

			GameManager.CoinType.YELLOW:
				amount_label.text = str(GameManager.yellow_amount) + " / " + str(GameManager.coin_cap)

			GameManager.CoinType.RED:
				amount_label.text = str(GameManager.red_amount) + " / " + str(GameManager.coin_cap)
