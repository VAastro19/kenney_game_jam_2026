# game_ui.gd
extends Control

@export var production_panel: Panel
@export var buildings_panel: Panel
@export var upgrades_panel: Panel

@export var l_click_label: Label
@export var l_click_icon: TextureRect
@export var r_click_label: Label
@export var r_click_icon: TextureRect

func _process(_delta: float) -> void:
	if GameManager.in_build_mode:
		l_click_label.visible = true
		l_click_icon.visible = true
		r_click_label.visible = true
		r_click_icon.visible = true
	else:
		l_click_label.visible = false
		l_click_icon.visible = false
		r_click_label.visible = false
		r_click_icon.visible = false

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
