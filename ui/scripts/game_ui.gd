# game_ui.gd
extends Control

@export var production_panel: Panel
@export var buildings_panel: Panel
@export var upgrades_panel: Panel

func _on_production_button_pressed() -> void:
	production_panel.visible = true
	buildings_panel.visible = false
	upgrades_panel.visible = false

func _on_buildings_button_pressed() -> void:
	production_panel.visible = false
	buildings_panel.visible = true
	upgrades_panel.visible = false

func _on_upgrades_button_pressed() -> void:
	production_panel.visible = false
	buildings_panel.visible = false
	upgrades_panel.visible = true
