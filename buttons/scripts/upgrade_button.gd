# upgrade_button.gd
class_name UpgradeButton extends Control

enum Upgrade {
	LUMBER_UNLOCK,
	BLACKSMITH_UNLOCK,
	CASTLE_UNLOCK,
	GREEN_UNLOCK,
	YELLOW_UNLOCK,
	RED_UNLOCK,
	CLICK_VALUE,
	WINDMILL_EFF,
	LUMBER_EFF,
	BLACKSMITH_EFF,
	CASTLE_EFF,
	MONUMENT
}

enum UpgradeType { UNLOCK, EFFICIENCY }

@onready var button: TextureButton = $Button
@onready var upgrade_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost
@onready var type_icon: TextureRect = $Button/UpgradeTypeIcon
@onready var bought_audio: AudioStreamPlayer = $BoughtAudio

@export var upgrade: Upgrade
@export var upgrade_type: UpgradeType
@export var buy_limit: int = 1
@export var cost: float
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var cur_buys: int = 0

func _ready() -> void:
	is_unlocked = true
	
	match upgrade_type:
		UpgradeType.UNLOCK:
			type_icon.texture = load("uid://c8b733my3oitb")
			
		UpgradeType.EFFICIENCY:
			type_icon.texture = load("uid://b5gg6v3ocb3d3")

	match upgrade:
		Upgrade.LUMBER_UNLOCK:
			button.texture_normal = load("uid://bgi0bao4co37d")
			upgrade_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 600[img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		Upgrade.BLACKSMITH_UNLOCK:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			upgrade_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Blacksmith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 2000 [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.CASTLE_UNLOCK:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			upgrade_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 10000 [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

		Upgrade.GREEN_UNLOCK:
			button.texture_normal = load("uid://c0cxtfjfkdxag")
			upgrade_name.text = "Green Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Green Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 500 [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		Upgrade.YELLOW_UNLOCK:
			button.texture_normal = load("uid://btpjfu7rn478t")
			upgrade_name.text = "Yellow Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Yellow Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 1800 [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.RED_UNLOCK:
			button.texture_normal = load("uid://dum12h5kdlrj4")
			upgrade_name.text = "Red Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Red Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 8000 [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

		Upgrade.CLICK_VALUE:
			button.texture_normal = load("uid://d0yg6bltmsihc")
			upgrade_name.text = "Click Upgrade"
			description_label.text = "[font_size=24][outline_size=2]Increases the click value"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(EconomyManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.WINDMILL_EFF:
			button.texture_normal = load("uid://b6md4j5iqompt")
			upgrade_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=blue]Windmill"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(EconomyManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.LUMBER_EFF:
			button.texture_normal = load("uid://bgi0bao4co37d")
			upgrade_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(EconomyManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.BLACKSMITH_EFF:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			upgrade_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=yellow]Blacksmiith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(EconomyManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.CASTLE_EFF:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			upgrade_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(EconomyManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		Upgrade.MONUMENT:
			button.texture_normal = load("uid://dypxvefsoecn2")
			upgrade_name.text = "Monument"
			description_label.text = "[font_size=24][outline_size=2][color=gold]Wins the game!"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 100000 [img=18]res://assets/graphics/coins/red_coin.png[/img]"

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal

func _on_button_pressed() -> void:
	if is_unlocked:
		match upgrade:
			Upgrade.LUMBER_UNLOCK:
				if 600 <= EconomyManager.blue_amount:
					EconomyManager.blue_amount -= 600
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(BuildManager.BuildingType.LUMBER)

			Upgrade.BLACKSMITH_UNLOCK:
				if 2000 <= EconomyManager.green_amount:
					EconomyManager.green_amount -= 2000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(BuildManager.BuildingType.BLACKSMITH)

			Upgrade.CASTLE_UNLOCK:
				if 10000 <= EconomyManager.yellow_amount:
					EconomyManager.yellow_amount -= 10000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(BuildManager.BuildingType.CASTLE)

			Upgrade.GREEN_UNLOCK:
				if 500 <= EconomyManager.blue_amount:
					EconomyManager.blue_amount -= 500
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(EconomyManager.CoinType.GREEN)

			Upgrade.YELLOW_UNLOCK:
				if 1800 <= EconomyManager.green_amount:
					EconomyManager.green_amount -= 1800
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(EconomyManager.CoinType.YELLOW)

			Upgrade.RED_UNLOCK:
				if 8000 <= EconomyManager.yellow_amount:
					EconomyManager.yellow_amount -= 8000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(EconomyManager.CoinType.RED)

			Upgrade.MONUMENT:
				if 1000000 <= EconomyManager.red_amount:
					EconomyManager.red_amount -= 100000
					cur_buys += 1
					_bought()
					EventBus.OnMonumentBuilt.emit()

func _bought() -> void:
	bought_audio.play()
	if cur_buys >= buy_limit:
		cost_label.text = "[font_size=32][outline_size=2][color=dark_green]BOUGHT"
		is_unlocked = false
