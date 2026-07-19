# coin_audio
extends AudioStreamPlayer

@onready var parent: BaseButton = get_parent()

@onready var coins_sounds: Array[AudioStream] =[
	preload("res://assets/audio/coin1.ogg"),
	preload("res://assets/audio/coin2.ogg")
]

func _ready() -> void:
	parent.pressed.connect(_play_audio)

func _play_audio() -> void:
	stream = coins_sounds.pick_random()
	play()
