# main_menu.gd
extends Control

@onready var button_panel: TextureRect = $ButtonPanel
@onready var settings_panel: TextureRect = $SettingsPanel
@onready var are_you_sure: Control = $AreYouSureDialog

func _on_play_button_pressed() -> void:
	SceneLoader.load_scene("uid://d3n1x02f68kiw")

func _on_settings_button_pressed() -> void:
	button_panel.visible = false
	settings_panel.visible = true

func _on_quit_button_pressed() -> void:
	button_panel.visible = false
	are_you_sure.visible = true

func _on_back_button_pressed() -> void:
	settings_panel.visible = false
	button_panel.visible = true
