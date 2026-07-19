# camera.gd
extends Camera2D

# Parameters for camera control
@export_range(0, 2000) var camera_speed: float = 1000 ## Allowed movement speed range for the camera
@export var edge_margin: float = 20 ## Defines how far from the edge camera starts panning
@export var map_size: Vector2 = Vector2(500, 480)
@export var allow_pan: bool = true

# Set this camera as active
func _ready() -> void:
	make_current()

# Handle all the inputs
func _process(delta: float) -> void:
	if allow_pan:
		_handle_keyboard_movement(delta) # Check for keyboard input camera movement
		_handle_edge_movement(delta) # Check for mouse input camera movement

# Keyboard input logic
func _handle_keyboard_movement(delta: float) -> void:
	var direction := Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		position += direction * camera_speed * delta
		position.x = clamp(position.x, -map_size.x / zoom.x, map_size.x / zoom.x)
		position.y = clamp(position.y, -map_size.y / zoom.y, map_size.y / zoom.y)

# Mouse input logic and edge scrolling
func _handle_edge_movement(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var view_pos = get_viewport().get_visible_rect().size
	var direction = Vector2.ZERO

	if mouse_pos.x <= edge_margin:
		direction.x -= 1
	elif mouse_pos.x >= view_pos.x - edge_margin:
		direction.x += 1
	if mouse_pos.y <= edge_margin:
		direction.y -= 1
	elif mouse_pos.y >= view_pos.y - edge_margin:
		direction.y += 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		position += direction * camera_speed * delta
		position.x = clamp(position.x, -map_size.x * zoom.x, map_size.x * zoom.x)
		position.y = clamp(position.y, -map_size.y * zoom.y, map_size.y * zoom.y)
