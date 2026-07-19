# audio_manager.gd
extends Control

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider

var master_index: int
var music_index: int
var sfx_index: int

func _ready() -> void:
	master_index = AudioServer.get_bus_index("Master")
	music_index = AudioServer.get_bus_index("Music")
	sfx_index = AudioServer.get_bus_index("SFX")
	
	master_slider.value = _get_volume(master_index)
	music_slider.value = _get_volume(music_index)
	sfx_slider.value = _get_volume(sfx_index)

func _get_volume(bus_index: int) -> float:
	var db_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db_volume)

func _set_volume(bus_index: int, volume: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, volume)

func _on_master_volume_slider_value_changed(value: float) -> void:
	_set_volume(master_index, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	_set_volume(music_index, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	_set_volume(sfx_index, value)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_quit_button_pressed() -> void:
	SceneLoader.load_scene("uid://jlbgrqoqh5fq")
