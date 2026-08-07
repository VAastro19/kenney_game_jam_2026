# are_you_sure_dialog.gd
extends Control

@onready var yes_button: Button = $HBoxContainer/YesButton
@onready var no_button: Button = $HBoxContainer/NoButton
@export var caller: Control

func  _ready() -> void:
	yes_button.pressed.connect(_on_yes_button_pressed)
	no_button.pressed.connect(_on_no_button_pressed)
	
	visible = false

func _on_yes_button_pressed() -> void:
	if caller.name == "ButtonPanel": # Quit if pressed from main menu
		get_tree().quit()
	else:
		SceneLoader.load_scene("uid://jlbgrqoqh5fq")

func _on_no_button_pressed() -> void:
	visible = false
	caller.visible = true
