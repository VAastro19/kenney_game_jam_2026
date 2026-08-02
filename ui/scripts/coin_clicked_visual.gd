# coin_clicked_visual.gd
class_name CoinClickedVisual extends Node

var blue_coin: Texture2D = preload("uid://c2pgc2wuco2a1")
var green_coin: Texture2D = preload("uid://c0cxtfjfkdxag")
var yellow_coin: Texture2D = preload("uid://btpjfu7rn478t")
var red_coin: Texture2D = preload("uid://dum12h5kdlrj4")

@export var duration: float = 0.25 ## Defines how long main part of the visual will last
@export var y_offset: float = 40.0 ## Defines how far up (in pixels) the coin will travel before disappearing
@export var x_offset: float = 100.0 ## Defines maximum horizontal offset of the coin
@export var coin_offset: Vector2 = Vector2(20, 20) ## Makes sure that coins appear at the center

func show_coins(pos: Vector2, type: EconomyManager.CoinType) -> void:
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
	
	var rand_y_offset = y_offset + randi_range(-10, 20)
	var rand_x_offset = x_offset + randi_range(-40, 40)
	
	await get_tree().create_timer(randf_range(0.01, 0.1)).timeout
	call_deferred("add_child", coin)
	coin.scale = Vector2(0.5, 0.5)
	coin.pivot_offset_ratio = Vector2(0.5, 0.5)
	coin.z_index = 0
	coin.position = pos + coin_offset
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		coin, "position:y", coin.position.y - rand_y_offset, duration
		).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		coin, "position:x", coin.position.x + randf_range(-rand_x_offset, rand_x_offset), duration * 2
		).set_ease(Tween.EASE_IN)
	tween.tween_property(
		coin, "position:y", coin.position.y + rand_y_offset, duration
		).set_ease(Tween.EASE_IN).set_delay(duration)
	tween.tween_property(
		coin, "modulate:a", 0, duration
		).set_ease(Tween.EASE_IN).set_delay(duration)
	await tween.finished
	coin.queue_free()
