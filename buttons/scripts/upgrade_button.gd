# upgrade_button.gd
class_name UpgradeButton extends Control

enum Upgrade {
	CLICK_VALUE,
	WINDMILL_EFF,
	LUMBER_EFF,
	BLACKSMITH_EFF,
	CASTLE_EFF,
	MONUMENT
}

@onready var button: TextureButton = $Button
@onready var upgrade_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost
@onready var type_icon: TextureRect = $Button/UpgradeTypeIcon
@onready var bought_audio: AudioStreamPlayer = $BoughtAudio

@export var upgrade: Upgrade
@export var buy_limit: int = 1
@export var cost_type: EconomyManager.CoinType
@export var cost_multiplier: float = 10.0
@export var initial_cost_offset: float = 5.0
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var cur_buys: int = 0
var cost_type_name: String
var upgrade_type_name: String
var cost: float:
	get: return EconomyManager.calculate_upgrade_cost(cost_multiplier, cur_buys + 1, initial_cost_offset)

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
	is_unlocked = true
	type_icon.texture = load("uid://b5gg6v3ocb3d3")
	cost_type_name = str(EconomyManager.CoinType.keys()[cost_type].to_lower())

	match upgrade:
		
		Upgrade.CLICK_VALUE:
			button.texture_normal = load("uid://d0yg6bltmsihc")
			upgrade_name.text = "Click Upgrade"
			description_label.text = "[font_size=24][outline_size=2]Doubles the click value"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

		Upgrade.WINDMILL_EFF:
			button.texture_normal = load("uid://b6md4j5iqompt")
			upgrade_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=blue]Windmill"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

		Upgrade.LUMBER_EFF:
			button.texture_normal = load("uid://bgi0bao4co37d")
			upgrade_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

		Upgrade.BLACKSMITH_EFF:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			upgrade_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=yellow]Blacksmiith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

		Upgrade.CASTLE_EFF:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			upgrade_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

		Upgrade.MONUMENT:
			button.texture_normal = load("uid://dypxvefsoecn2")
			upgrade_name.text = "Monument"
			description_label.text = "[font_size=24][outline_size=2][color=gold]Wins the game!"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + "[img=18]res://assets/graphics/coins/" + cost_type_name + "_coin.png[/img]"

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal
	
	upgrade_type_name = str(Upgrade.keys()[upgrade].to_lower())

func _process(_delta: float) -> void:
	cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(cost)) + " [img=18]res://assets/graphics/coins/" + str(cost_type_name) + "_coin.png[/img]"

func _on_button_pressed() -> void:
	if is_unlocked:
		if cost <= EconomyManager.get(cost_type_name + "_amount"):
			EconomyManager.set(cost_type_name + "_amount", EconomyManager.get(cost_type_name + "_amount") - cost)
			_bought()
			if upgrade == Upgrade.MONUMENT:
				EventBus.OnMonumentBuilt.emit()
			else:
				EconomyManager.set(upgrade_type_name + "_count", EconomyManager.get(upgrade_type_name + "_count") + 1)

func _bought() -> void:
	bought_audio.play()
	cur_buys += 1
	if cur_buys >= buy_limit:
		cost_label.text = "[font_size=32][outline_size=2][color=dark_green]BOUGHT"
		is_unlocked = false
