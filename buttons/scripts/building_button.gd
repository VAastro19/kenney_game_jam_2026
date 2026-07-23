# building_button.gd
class_name BuildingButton extends Control

@onready var button: TextureButton = $Button
@onready var building_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost

@export var building_type: BuildManager.BuildingType
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

func _ready() -> void:
	EventBus.OnUnlockBuilding.connect(_on_unlock_building)
	button.pressed.connect(_on_button_pressed)
	
	match building_type:
		BuildManager.BuildingType.WAREHOUSE:
			button.texture_normal = load("uid://dk6ilksd4po4t")
			building_name.text = "Warehouse"
			description_label.text = "[font_size=24][outline_size=2]Increases the coin cap"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.warehouse_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = true

		BuildManager.BuildingType.WINDMILL:
			button.texture_normal = load("uid://b6md4j5iqompt")
			building_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=blue]Blue Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.windmill_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = true

		BuildManager.BuildingType.LUMBER:
			button.texture_normal = load("uid://bgi0bao4co37d")
			building_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=green]Green Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.lumber_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = false

		BuildManager.BuildingType.BLACKSMITH:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			building_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=yellow]Yellow Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.blacksmith_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = false

		BuildManager.BuildingType.CASTLE:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			building_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=red]Red Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.castle_cost)) + " [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"
			is_unlocked = false

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal

func _process(_delta: float) -> void:
	match building_type:
		BuildManager.BuildingType.WAREHOUSE:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.warehouse_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		BuildManager.BuildingType.WINDMILL:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.windmill_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		BuildManager.BuildingType.LUMBER:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.lumber_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		BuildManager.BuildingType.BLACKSMITH:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.blacksmith_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		BuildManager.BuildingType.CASTLE:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(EconomyManager.castle_cost)) + " [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

func _on_button_pressed() -> void:
	if is_unlocked:
		BuildManager.selected_building = building_type
		BuildManager.in_build_mode = true

func _on_unlock_building(type: BuildManager.BuildingType) -> void:
	if type == building_type:
		is_unlocked = true
