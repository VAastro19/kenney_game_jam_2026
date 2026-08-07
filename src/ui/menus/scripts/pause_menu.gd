# pause_menu.gd
extends Control

@onready var settings_panel: Control = $SettingsPanel
@onready var are_you_sure: Control = $AreYouSureDialog
@onready var quit_button: Button = $SettingsPanel/VBoxContainer/QuitButton

func _ready() -> void:
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	visible = false

func _on_quit_button_pressed() -> void:
	settings_panel.visible = false
	are_you_sure.visible = true
