# building_button.gd
class_name BuildingButton extends Control

@onready var economy_manager: Node = %EconomyManager
@onready var build_manager: Node = %BuildManager

@onready var button: TextureButton = $Button
@onready var building_name: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var cost_label: RichTextLabel = $Cost

@export var building_type: Enums.BuildingType
@export var cost_type: Enums.CoinType
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var cost_type_name: String
var building_type_name: String

func _ready() -> void:
	EventBus.OnUnlockBuilding.connect(_on_unlock_building)
	button.pressed.connect(_on_button_pressed)
	
	match building_type:
		Enums.BuildingType.WAREHOUSE:
			button.texture_normal = load("uid://dk6ilksd4po4t")
			building_name.text = "Warehouse"
			description_label.text = "[font_size=24][outline_size=2]Increases the coin cap"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.warehouse_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = true

		Enums.BuildingType.WINDMILL:
			button.texture_normal = load("uid://b6md4j5iqompt")
			building_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=blue]Blue Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.windmill_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = true

		Enums.BuildingType.LUMBER:
			button.texture_normal = load("uid://bgi0bao4co37d")
			building_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=green]Green Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.lumber_cost)) + " [img=18]res://assets/graphics/coins/blue_coin.png[/img]"
			is_unlocked = false

		Enums.BuildingType.BLACKSMITH:
			button.texture_normal = load("uid://cevy4agyfjnkj")
			building_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=yellow]Yellow Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.blacksmith_cost)) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"
			is_unlocked = false

		Enums.BuildingType.CASTLE:
			button.texture_normal = load("uid://dyyn6r58gr3br")
			building_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Produces [color=red]Red Coins"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.castle_cost)) + " [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"
			is_unlocked = false

	button.texture_disabled = button.texture_normal
	button.texture_pressed = button.texture_normal
	button.texture_hover = button.texture_normal
	button.texture_focused = button.texture_normal
	
	cost_type_name = Enums.CoinType.keys()[cost_type].to_lower()
	building_type_name = Enums.BuildingType.keys()[building_type].to_lower()

func _process(_delta: float) -> void:
	if building_type == Enums.BuildingType.WAREHOUSE:
		if economy_manager.warehouses != 2:
			pass
		else:
			_change_cost_type(Enums.CoinType.YELLOW)

		if economy_manager.warehouses != 4:
			pass
		else:
			_change_cost_type(Enums.CoinType.RED)

	cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(int(economy_manager.get(building_type_name + "_cost"))) + " [img=18]res://assets/graphics/coins/" + str(cost_type_name) + "_coin.png[/img]"

func _change_cost_type(new_cost_type: Enums.CoinType) -> void:
	cost_type = new_cost_type
	cost_type_name = Enums.CoinType.keys()[cost_type].to_lower()
	build_manager.warehouse_cost_type = new_cost_type

func _on_button_pressed() -> void:
	if is_unlocked:
		build_manager.selected_building = building_type
		build_manager.in_build_mode = true

func _on_unlock_building(type: Enums.BuildingType) -> void:
	if type == building_type:
		is_unlocked = true
