# upgrade_button_visuals.gd
extends TextureButton

@onready var parent: UpgradeButton = get_parent()
@onready var upgrade_name: Label = $"../Name"
@onready var description_label: RichTextLabel = $"../Description"
@onready var cost_label: RichTextLabel = $"../Cost"

var normal_scale: float = 0.5
var big_scale: float = 0.55
var small_scale: float = 0.45

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	match parent.upgrade:
		parent.Upgrade.LUMBER_UNLOCK:
			texture_normal = load("uid://bgi0bao4co37d")
			upgrade_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 600[img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		parent.Upgrade.BLACKSMITH_UNLOCK:
			texture_normal = load("uid://cevy4agyfjnkj")
			upgrade_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Blacksmith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 2000 [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.CASTLE_UNLOCK:
			texture_normal = load("uid://dyyn6r58gr3br")
			upgrade_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 10000 [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

		parent.Upgrade.GREEN_UNLOCK:
			texture_normal = load("uid://c0cxtfjfkdxag")
			upgrade_name.text = "Green Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=green]Green Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 500 [img=18]res://assets/graphics/coins/blue_coin.png[/img]"

		parent.Upgrade.YELLOW_UNLOCK:
			texture_normal = load("uid://btpjfu7rn478t")
			upgrade_name.text = "Yellow Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=yellow]Yellow Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 1800 [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.RED_UNLOCK:
			texture_normal = load("uid://dum12h5kdlrj4")
			upgrade_name.text = "Red Generator"
			description_label.text = "[font_size=24][outline_size=2]Unlocks the [color=red]Red Coin"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 8000 [img=18]res://assets/graphics/coins/yellow_coin.png[/img]"

		parent.Upgrade.CLICK_VALUE:
			texture_normal = load("uid://d0yg6bltmsihc")
			upgrade_name.text = "Click Upgrade"
			description_label.text = "[font_size=24][outline_size=2]Increases the click value"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(GameManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.WINDMILL_EFF:
			texture_normal = load("uid://b6md4j5iqompt")
			upgrade_name.text = "Windmill"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=blue]Windmill"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(GameManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.LUMBER_EFF:
			texture_normal = load("uid://bgi0bao4co37d")
			upgrade_name.text = "Lumber"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=green]Lumber"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(GameManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.BLACKSMITH_EFF:
			texture_normal = load("uid://cevy4agyfjnkj")
			upgrade_name.text = "Blacksmith"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=yellow]Blacksmiith"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(GameManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.CASTLE_EFF:
			texture_normal = load("uid://dyyn6r58gr3br")
			upgrade_name.text = "Castle"
			description_label.text = "[font_size=24][outline_size=2]Upgrades the [color=red]Castle"
			cost_label.text = "[font_size=28][outline_size=4]Cost: " + str(GameManager.warehouse_cost) + " [img=18]res://assets/graphics/coins/green_coin.png[/img]"

		parent.Upgrade.MONUMENT:
			texture_normal = load("uid://dypxvefsoecn2")
			upgrade_name.text = "Monument"
			description_label.text = "[font_size=24][outline_size=2][color=gold]Wins the game!"
			cost_label.text = "[font_size=28][outline_size=4]Cost: 1000000 [img=18]res://assets/graphics/coins/red_coin.png[/img]"

	texture_disabled = texture_normal
	texture_pressed = texture_normal
	texture_hover = texture_normal
	texture_focused = texture_normal

func _on_mouse_entered() -> void:
	if parent.is_unlocked:
		scale.x = lerpf(scale.x, big_scale, 1.0)
		scale.y = lerpf(scale.y, big_scale, 1.0)

func _on_mouse_exited() -> void:
	if parent.is_unlocked:
		scale.x = lerpf(scale.x, normal_scale, 1.0)
		scale.y = lerpf(scale.y, normal_scale, 1.0)

func _on_pressed() -> void:
	if parent.is_unlocked:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(small_scale, small_scale), 0.05)
		tween.tween_property(self, "scale", Vector2(big_scale, big_scale), 0.05)
