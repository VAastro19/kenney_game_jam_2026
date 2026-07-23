# godot_splashscreen.gd
extends Control

@export var animation_player: AnimationPlayer

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	await get_tree().create_timer(2).timeout
	SceneLoader.load_scene("uid://jlbgrqoqh5fq")
