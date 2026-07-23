# coin_button.gd
class_name CoinButton extends Control

@onready var button: TextureButton = $Button
@onready var label: Label = $Label

@export var coin_type: EconomyManager.CoinType
@export var click_value: float = 1
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

func _ready() -> void:
	EventBus.OnUnlockGenerator.connect(_on_unlock_generator)
	button.pressed.connect(_on_button_pressed)

	match coin_type:
		EconomyManager.CoinType.BLUE:
			button.texture_normal = load("uid://c2pgc2wuco2a1")
			is_unlocked = true
		EconomyManager.CoinType.GREEN:
			button.texture_normal = load("uid://c0cxtfjfkdxag")
			is_unlocked = false
		EconomyManager.CoinType.YELLOW:
			button.texture_normal = load("uid://btpjfu7rn478t")
			is_unlocked = false
		EconomyManager.CoinType.RED:
			button.texture_normal = load("uid://dum12h5kdlrj4")
			is_unlocked = false

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal

func _process(_delta: float) -> void:
	match coin_type:
		EconomyManager.CoinType.BLUE:
			label.text = str(int(EconomyManager.blue_production)) + " / s"
		EconomyManager.CoinType.GREEN:
			label.text = str(int(EconomyManager.green_production)) + " / s"
		EconomyManager.CoinType.YELLOW:
			label.text = str(int(EconomyManager.yellow_production)) + " / s"
		EconomyManager.CoinType.RED:
			label.text = str(int(EconomyManager.red_production)) + " / s"

func _on_button_pressed() -> void:
	if is_unlocked:
		EventBus.OnClick.emit(click_value, coin_type)

func _on_unlock_generator(type: EconomyManager.CoinType) -> void:
	if type == coin_type:
		is_unlocked = true
