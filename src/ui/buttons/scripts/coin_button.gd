# coin_button.gd
class_name CoinButton extends Control

@onready var economy_manager: Node = %EconomyManager

@onready var button: TextureButton = $Button
@onready var label: Label = $Label
@onready var particles: Node = $CoinClickedVisual
@onready var number_visual: Node = $NumberProducedVisual

@export var coin_type: Enums.CoinType

@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var coin_type_name: String
var click_value: float:
	get: return max(1, 2 ** economy_manager.click_value_count)

func _ready() -> void:
	EventBus.OnUnlockGenerator.connect(_on_unlock_generator)
	button.pressed.connect(_on_button_pressed)

	match coin_type:
		Enums.CoinType.BLUE:
			button.texture_normal = load("uid://c2pgc2wuco2a1")
			is_unlocked = true
		Enums.CoinType.GREEN:
			button.texture_normal = load("uid://c0cxtfjfkdxag")
			is_unlocked = false
		Enums.CoinType.YELLOW:
			button.texture_normal = load("uid://btpjfu7rn478t")
			is_unlocked = false
		Enums.CoinType.RED:
			button.texture_normal = load("uid://dum12h5kdlrj4")
			is_unlocked = false

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal
	
	coin_type_name = Enums.CoinType.keys()[coin_type].to_lower() + "_production"

func _process(_delta: float) -> void:
	label.text = str(snappedf(economy_manager.get(coin_type_name), 0.1)) + " / s"

func _on_button_pressed() -> void:
	if is_unlocked:
		EventBus.OnClick.emit(click_value, coin_type)
		for i in range(maxi(int(click_value), 16)):
			particles.show_coins(global_position, coin_type)
		number_visual.show_number_produced(global_position, click_value)

func _on_unlock_generator(type: Enums.CoinType) -> void:
	if type == coin_type:
		is_unlocked = true
