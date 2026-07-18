# building_button.gd
class_name BuildingButton extends Control

@onready var button: TextureButton = $Button
@onready var building_name: Label = $Name
@onready var description: RichTextLabel = $Description

@export var building_type: GameManager.BuildingType

func _ready() -> void:
	match building_type:
		GameManager.BuildingType.WAREHOUSE:
			building_name.text = "Warehouse"
			description.text = "[font_size=24][outline_size=2]Increases the coin cap"

		GameManager.BuildingType.WINDMILL:
			building_name.text = "Windmill"
			description.text = "[font_size=24][outline_size=2]Produces [color=blue]Blue Coins"

		GameManager.BuildingType.LUMBER:
			building_name.text = "Lumber"
			description.text = "[font_size=24][outline_size=2]Produces [color=green]Green Coins"

		GameManager.BuildingType.BLACKSMITH:
			building_name.text = "Blacksmith"
			description.text = "[font_size=24][outline_size=2]Produces [color=yellow]Yellow Coins"

		GameManager.BuildingType.CASTLE:
			building_name.text = "Castle"
			description.text = "[font_size=24][outline_size=2]Produces [color=red]Red Coins"

func _on_button_pressed() -> void:
	GameManager.selected_building = building_type
	GameManager.in_build_mode = true
