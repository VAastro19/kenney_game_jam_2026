# building_button_visuals.gd
extends TextureButton

@onready var parent: BuildingButton = get_parent()

var normal_scale: float = 0.5
var big_scale: float = 0.55
var small_scale: float = 0.45

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	match parent.building_type:
		GameManager.BuildingType.WAREHOUSE:
			texture_normal = load("uid://dk6ilksd4po4t")

		GameManager.BuildingType.WINDMILL:
			texture_normal = load("uid://b6md4j5iqompt")

		GameManager.BuildingType.LUMBER:
			texture_normal = load("uid://bgi0bao4co37d")

		GameManager.BuildingType.BLACKSMITH:
			texture_normal = load("uid://cevy4agyfjnkj")

		GameManager.BuildingType.CASTLE:
			texture_normal = load("uid://dyyn6r58gr3br")

		_:
			texture_normal = load("uid://dk6ilksd4po4t")

	texture_disabled = texture_normal
	texture_pressed = texture_normal
	texture_hover = texture_normal
	texture_focused = texture_normal

func _on_mouse_entered() -> void:
	scale.x = lerpf(scale.x, big_scale, 1.0)
	scale.y = lerpf(scale.y, big_scale, 1.0)

func _on_mouse_exited() -> void:
	scale.x = lerpf(scale.x, normal_scale, 1.0)
	scale.y = lerpf(scale.y, normal_scale, 1.0)

func _on_pressed() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(small_scale, small_scale), 0.05)
	tween.tween_property(self, "scale", Vector2(big_scale, big_scale), 0.05)
