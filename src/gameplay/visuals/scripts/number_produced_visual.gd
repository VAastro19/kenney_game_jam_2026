# number_produced_visual.gd
extends Node

@export var default_font_size: int = 100 ## Sets damage number font size for when size multiplier is equal to one.
@export var duration: float = 1.0 ## Defines how long main part of the visual will last
@export var y_offset: float = 100.0 ## Defines how far up (in pixels) the coin will travel before disappearing
@export var coin_offset: Vector2 = Vector2(16, 20) ## Defines where on the coin calculating from the center will coin appear

func show_number_produced(pos: Vector2, value: float) -> void:
	var number = Label.new()
	number.label_settings = LabelSettings.new()

	number.position = Vector2.ZERO
	
	number.label_settings.outline_color = Color.BLACK
	number.label_settings.outline_size = 8
	
	number.label_settings.shadow_color = Color.BLACK
	number.label_settings.outline_size = 4
	
	number.label_settings.font_color = Color.WHITE
	number.label_settings.font_size = default_font_size

	call_deferred("add_child", number)
	number.mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED

	number.scale = Vector2(0.5, 0.5)
	number.pivot_offset_ratio = Vector2(0.5, 0.5)
	number.z_index = 2
	number.position = pos + coin_offset

	number.text = "+" + str(int(value))
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - y_offset, duration
		).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "modulate:a", 0, duration).set_ease(Tween.EASE_IN)
	await tween.finished
	number.queue_free()
