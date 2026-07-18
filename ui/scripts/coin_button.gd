# coin_button.gd
class_name CoinButton extends Control

@onready var button: TextureButton = $Button
@onready var label: Label = $Label

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

func _process(_delta: float) -> void:
	match coin_type:
		GameManager.CoinType.BLUE:
			label.text = str(GameManager.blue_production) + " / s"
		GameManager.CoinType.GREEN:
			label.text = str(GameManager.green_production) + " / s"
		GameManager.CoinType.YELLOW:
			label.text = str(GameManager.yellow_production) + " / s"
		GameManager.CoinType.RED:
			label.text = str(GameManager.red_production) + " / s"

func _on_button_pressed() -> void:
	if is_unlocked:
		EventBus.OnClick.emit(click_value, coin_type)
