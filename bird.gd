extends Area2D

@export var speed := 1000.0
@export var turn_speed := 2.5


var direction := Vector2.RIGHT
var target_direction := Vector2.RIGHT

@export var min_x := -800
@export var max_x := 800

@export var min_y := -400
@export var max_y := 400

func _ready():
	add_to_group("bird")

	direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

	target_direction = direction

func _process(delta):

	# 방향을 천천히 회전
	direction = direction.lerp(
		target_direction,
		turn_speed * delta
	).normalized()

	position += direction * speed * delta

	# 벽 근처면 안쪽으로 목표 방향 변경
	if position.x < min_x:
		target_direction = Vector2.RIGHT.rotated(randf_range(-1.0, 1.0))

	if position.x > max_x:
		target_direction = Vector2.LEFT.rotated(randf_range(-1.0, 1.0))

	if position.y < min_y:
		target_direction = Vector2.DOWN.rotated(randf_range(-1.0, 1.0))

	if position.y > max_y:
		target_direction = Vector2.UP.rotated(randf_range(-1.0, 1.0))

	$Sprite2D.flip_h = direction.x < 0

func _on_direction_timer_timeout():

	target_direction = direction.rotated(
		deg_to_rad(randf_range(-120, 120))
	).normalized()
