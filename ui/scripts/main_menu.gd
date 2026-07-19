# main_menu.gd
extends Control

@onready var button_panel: TextureRect = $ButtonPanel
@onready var settings_panel: TextureRect = $SettingsPanel

func _on_play_button_pressed() -> void:
	SceneLoader.load_scene("uid://bwvej8u5ivcdm")

func _on_settings_button_pressed() -> void:
	button_panel.visible = false
	settings_panel.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	settings_panel.visible = false
	button_panel.visible = true
