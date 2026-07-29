# coin_produced_visual.gd
class_name CoinProducedVisual extends Node

var blue_coin: Texture2D = preload("uid://c2pgc2wuco2a1")
var green_coin: Texture2D = preload("uid://c0cxtfjfkdxag")
var yellow_coin: Texture2D = preload("uid://btpjfu7rn478t")
var red_coin: Texture2D = preload("uid://dum12h5kdlrj4")

@export var duration: float = 0.7 ## Defines how long main part of the visual will last
@export var y_offset: float = 80.0 ## Defines how far up (in pixels) the coin will travel before disappearing
@export var hex_offset: Vector2 = Vector2(23, 80) ## Defines where on the hex calculating from the center will coin appear

func show_coin_produced(pos: Vector2, type: EconomyManager.CoinType) -> void:
	var coin = TextureRect.new()
	
	match type:
		EconomyManager.CoinType.BLUE:
			coin.texture = blue_coin
		EconomyManager.CoinType.GREEN:
			coin.texture = green_coin
		EconomyManager.CoinType.YELLOW:
			coin.texture = yellow_coin
		EconomyManager.CoinType.RED:
			coin.texture = red_coin

	call_deferred("add_child", coin)
	coin.scale = Vector2(0.5, 0.5)
	coin.pivot_offset_ratio = Vector2(0.5, 0.5)
	coin.z_index = 2
	coin.position = pos - Vector2(23, 80)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		coin, "position:y", coin.position.y - y_offset, duration
		).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		coin, "modulate:a", 0, duration).set_ease(Tween.EASE_IN)
	await tween.finished
	coin.queue_free()
