# unlock_button.gd
class_name UnlockButton extends Control

@onready var economy_manager: Node = %EconomyManager

@onready var button: TextureButton = $Button
@onready var unlock_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost
@onready var type_icon: TextureRect = $Button/UnlockTypeIcon
@onready var bought_audio: AudioStreamPlayer = $BoughtAudio

@export var unlock: Enums.Unlock
@export var cost: float
@export var cost_type: Enums.CoinType
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var building_type: Enums.BuildingType = Enums.BuildingType.NONE
var generator_type: Enums.CoinType = Enums.CoinType.NONE
var is_bulding: bool = true
var cost_type_name: String

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
	is_unlocked = true
	type_icon.texture = load("uid://c8b733my3oitb")
	cost_type_name = str(Enums.CoinType.keys()[cost_type].to_lower())

	match unlock:
		Enums.Unlock.LUMBER:
			button.texture_normal = load("uid://bgi0bao4co37d")
			unlock_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			building_type = Enums.BuildingType.LUMBER
			is_bulding = true

		Enums.Unlock.BLACKSMITH:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			unlock_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Blacksmith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			building_type = Enums.BuildingType.BLACKSMITH
			is_bulding = true

		Enums.Unlock.CASTLE:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			unlock_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			building_type = Enums.BuildingType.CASTLE
			is_bulding = true

		Enums.Unlock.GREEN_GEN:
			button.texture_normal = load("uid://c0cxtfjfkdxag")
			unlock_name.text = "Green Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Green Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			generator_type = Enums.CoinType.GREEN
			is_bulding = false

		Enums.Unlock.YELLOW_GEN:
			button.texture_normal = load("uid://btpjfu7rn478t")
			unlock_name.text = "Yellow Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Yellow Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			generator_type = Enums.CoinType.YELLOW
			is_bulding = false

		Enums.Unlock.RED_GEN:
			button.texture_normal = load("uid://dum12h5kdlrj4")
			unlock_name.text = "Red Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Red Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"
			generator_type = Enums.CoinType.RED
			is_bulding = false

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal

func _on_button_pressed() -> void:
	if is_unlocked:
		if cost <= economy_manager.get(cost_type_name + "_amount"):
			economy_manager.set(cost_type_name + "_amount", economy_manager.get(cost_type_name + "_amount") - cost)
			_bought()
			if is_bulding:
				EventBus.OnUnlockBuilding.emit(building_type)
			else:
				EventBus.OnUnlockGenerator.emit(generator_type)

func _bought() -> void:
	bought_audio.play()
	cost_label.text = "[font_size=32][outline_size=2][color=dark_green]BOUGHT"
	is_unlocked = false
	button.scale = Vector2(0.5, 0.5)
