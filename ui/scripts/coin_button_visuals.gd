# coin_button_visuals.gd
extends TextureButton

@onready var parent: CoinButton = get_parent()

var normal_scale: float = 1.0
var big_scale: float = 1.1
var small_scale: float = 0.9

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	match parent.coin_type:
		GameManager.CoinType.BLUE:
			texture_normal = load("uid://c2pgc2wuco2a1")
		GameManager.CoinType.GREEN:
			texture_normal = load("uid://c0cxtfjfkdxag")
		GameManager.CoinType.YELLOW:
			texture_normal = load("uid://btpjfu7rn478t")
		GameManager.CoinType.RED:
			texture_normal = load("uid://dum12h5kdlrj4")
	
	texture_disabled = texture_normal
	texture_pressed = texture_normal
	texture_hover = texture_normal
	texture_focused = texture_normal

func _on_mouse_entered() -> void:
	if parent.is_unlocked:
		scale.x = lerpf(scale.x, big_scale, 1.0)
		scale.y = lerpf(scale.y, big_scale, 1.0)

func _on_mouse_exited() -> void:
	if parent.is_unlocked:
		scale.x = lerpf(scale.x, normal_scale, 1.0)
		scale.y = lerpf(scale.y, normal_scale, 1.0)

func _on_pressed() -> void:
	if parent.is_unlocked:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(small_scale, small_scale), 0.05)
		tween.tween_property(self, "scale", Vector2(big_scale, big_scale), 0.05)
