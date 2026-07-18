# coin_button.gd
class_name CoinButton extends Control

@onready var button: TextureButton = $Button

@export var coin_type: GameManager.CoinType
@export var click_value: float = 1
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
	match coin_type:
		GameManager.CoinType.BLUE:
			is_unlocked = true
		GameManager.CoinType.GREEN:
			is_unlocked = false
		GameManager.CoinType.YELLOW:
			is_unlocked = false
		GameManager.CoinType.RED:
			is_unlocked = false

func _on_button_pressed() -> void:
	if is_unlocked:
		EventBus.OnUpdateCoin.emit(click_value, coin_type)
