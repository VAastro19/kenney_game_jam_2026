# building_button.gd
class_name BuildingButton extends Control

@onready var button: TextureButton = $Button
@onready var building_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost

@export var building_type: GameManager.BuildingType
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

func _ready() -> void:
	EventBus.OnUnlockBuilding.connect(_on_unlock_building)
	
	match building_type:
		GameManager.BuildingType.WAREHOUSE:
			building_name.text = "Warehouse"
			description_label.text = "[font_size=24][outline_size=2]Increases the coin cap"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.warehouse_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = true

		GameManager.BuildingType.WINDMILL:
			building_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=blue]Blue Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.windmill_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = true

		GameManager.BuildingType.LUMBER:
			building_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=green]Green Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.lumber_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = false

		GameManager.BuildingType.BLACKSMITH:
			building_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=yellow]Yellow Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.blacksmith_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = false

		GameManager.BuildingType.CASTLE:
			building_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=red]Red Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.castle_cost)) + " [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"
			is_unlocked = false

func _process(_delta: float) -> void:
	match building_type:
		GameManager.BuildingType.WAREHOUSE:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.warehouse_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		GameManager.BuildingType.WINDMILL:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.windmill_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		GameManager.BuildingType.LUMBER:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.lumber_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		GameManager.BuildingType.BLACKSMITH:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.blacksmith_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		GameManager.BuildingType.CASTLE:
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(GameManager.castle_cost)) + " [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

func _on_button_pressed() -> void:
	if is_unlocked:
		GameManager.selected_building = building_type
		GameManager.in_build_mode = true

func _on_unlock_building(type: GameManager.BuildingType) -> void:
	if type == building_type:
		is_unlocked = true
