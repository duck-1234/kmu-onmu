extends RigidBody2D

var power = 0
var thrown = false
var try_count = 0

@onready var player = $"../Player"
@onready var power_bar = $"../CanvasLayer/ProgressBar"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	freeze = true

func _process(delta):

	# 던지지 않았을 때 손 위치 따라감
	if !thrown:

		global_position = player.global_position + Vector2(-50, -50)

		look_at(get_global_mouse_position())

	# 힘 충전
	if Input.is_action_pressed("shoot") and !thrown:

		power += delta * 600
		power = clamp(power, 0, 1200)

		power_bar.value = power

	# 발사
	if Input.is_action_just_released("shoot") and !thrown:

		throw_spear()

		power_bar.value = 0

func throw_spear():

	thrown = true

	freeze = false

	var direction = Vector2.RIGHT.rotated(rotation)

	linear_velocity = direction * power

	power = 0

	# 2초 뒤 복귀
	await get_tree().create_timer(2.0).timeout

	try_count += 1
	
	reset_spear()

	
func reset_spear():

	thrown = false

	freeze = true

	linear_velocity = Vector2.ZERO

	angular_velocity = 0

	power = 0

	power_bar.value = 0

func _physics_process(delta):

	# 날아가는 방향 회전
	if thrown and linear_velocity.length() > 5:

		rotation = linear_velocity.angle()


func _on_apple_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
