# button_audio
extends AudioStreamPlayer

@onready var parent: BaseButton = get_parent()
@onready var grandparent: Control = get_parent().get_parent()

@onready var hover_sound: AudioStream = preload("res://assets/audio/hover.ogg")
@onready var click_sound: AudioStream = preload("res://assets/audio/click.ogg")
@onready var coins_sounds: Array[AudioStream] =[
	preload("res://assets/audio/coin1.ogg"),
	preload("res://assets/audio/coin2.ogg")
]

func _ready() -> void:
	parent.mouse_entered.connect(_play_hover_audio)
	parent.pressed.connect(_choose_pressed_sound)

func _choose_pressed_sound() -> void:
	if grandparent is CoinButton:
		_play_coins_audio()
	else:
		_play_click_audio()

func _play_hover_audio() -> void:
	_play_audio(hover_sound)

func _play_click_audio() -> void:
	_play_audio(click_sound)

func _play_coins_audio() -> void:
	var audio = coins_sounds.pick_random()
	_play_audio(audio)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
