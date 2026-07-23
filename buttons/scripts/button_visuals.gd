# button_visuals.gd
extends BaseButton

@onready var parent: Control = get_parent()

var normal_scale: float = scale.x
var big_scale: float = scale.x * 1.1
var small_scale: float = scale.x * 0.9

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	pivot_offset_ratio = Vector2(0.5, 0.5)

func _on_mouse_entered() -> void:
	if "is_unlocked" in parent:
		if not parent.is_unlocked:
			return
	scale.x = lerpf(scale.x, big_scale, 1.0)
	scale.y = lerpf(scale.y, big_scale, 1.0)

func _on_mouse_exited() -> void:
	if "is_unlocked" in parent:
		if not parent.is_unlocked:
			return
	scale.x = lerpf(scale.x, normal_scale, 1.0)
	scale.y = lerpf(scale.y, normal_scale, 1.0)

func _on_pressed() -> void:
	BuildManager.in_build_mode = false
	if "is_unlocked" in parent:
		if not parent.is_unlocked:
			return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(small_scale, small_scale), 0.05)
	tween.tween_property(self, "scale", Vector2(big_scale, big_scale), 0.05)
