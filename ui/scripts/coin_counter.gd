# coin_counter.gd
class_name CoinCounter extends Control

@onready var coin_texture: TextureRect = $HBoxContainer/CoinIcon
@onready var amount_label: Label = $HBoxContainer/CoinCounterLabel

@export var coin_type: GameManager.CoinType
var cur_amount: float = 0

func _ready() -> void:
	EventBus.OnUpdateCoin.connect(_on_coin_update)
	
	match coin_type:
		GameManager.CoinType.BLUE:
			coin_texture.texture = load("uid://c2pgc2wuco2a1")
			cur_amount = GameManager.blue_amount

		GameManager.CoinType.GREEN:
			coin_texture.texture = load("uid://c0cxtfjfkdxag")
			cur_amount = GameManager.green_amount

		GameManager.CoinType.YELLOW:
			coin_texture.texture = load("uid://btpjfu7rn478t")
			cur_amount = GameManager.yellow_amount

		GameManager.CoinType.RED:
			coin_texture.texture = load("uid://dum12h5kdlrj4")
			cur_amount = GameManager.red_amount

func _on_coin_update(amount: float, type: GameManager.CoinType) -> void:
	if type == coin_type:
		if cur_amount + amount <= GameManager.coin_cap:
			cur_amount += amount
			amount_label.text = str(cur_amount) + " / " + str(GameManager.coin_cap)

func _on_coin_cap_update() -> void:
	_on_coin_update(0, coin_type)
