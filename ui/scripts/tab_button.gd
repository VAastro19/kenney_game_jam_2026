# custom_button.gd
class_name TabButton extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	GameManager.in_build_mode = false
