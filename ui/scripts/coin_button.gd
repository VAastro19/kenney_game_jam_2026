# coin_button.gd
class_name CoinButton extends Control

@onready var button: TextureButton = $Button

@export var coin_type: GameManager.CoinType
@export var click_value: int = 1

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	EventBus.OnUpdateCoin.emit(click_value, coin_type)
