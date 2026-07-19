# button_audio
extends AudioStreamPlayer

@onready var parent: BaseButton = get_parent()

@onready var hover_sound: AudioStream = preload("res://assets/audio/hover.ogg")
@onready var click_sound: AudioStream = preload("res://assets/audio/click.ogg")

func _ready() -> void:
	parent.mouse_entered.connect(_play_hover_audio)
	parent.pressed.connect(_play_click_audio)

func _play_hover_audio() -> void:
	_play_audio(hover_sound)

func _play_click_audio() -> void:
	_play_audio(click_sound)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
