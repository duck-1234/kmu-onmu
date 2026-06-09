extends CharacterBody2D

const SPEED = 300.0
var can_move = true

@onready var sprite = $AnimatedSprite2D
@onready var interact_label = $Label

var last_direction = "front"

# 상호작용
var can_interact = false
var current_target = null

# 윤곽선
var outline_count = 0


func _ready():

	can_interact = false
	interact_label.visible = false

	# 윤곽선 기본 OFF
	if sprite.material:
		sprite.material = sprite.material.duplicate()
		sprite.material.set("shader_parameter/outline_size", 0.0)


func _process(delta):

	# =========================
	# 상호작용 UI
	# =========================
	if can_interact and current_target:

		# 문
		if current_target.is_in_group("door"):
			interact_label.text = "F를 눌러 이동"

		# 전시물
		elif current_target.is_in_group("game"):
			interact_label.text = "E: 조사하기"

		else:
			interact_label.text = "상호작용"

		interact_label.visible = true

	else:
		interact_label.visible = false


	# =========================
	# 상호작용 실행
	# =========================
	if can_interact and current_target != null:

		# 문 → F
		if current_target.is_in_group("door"):

			if Input.is_action_just_pressed("interact_door"):

				if current_target.has_method("interact"):

					print("문 상호작용:", current_target.name)

					current_target.interact()


		# 전시물 → E
		elif current_target.is_in_group("game"):

			if Input.is_action_just_pressed("interact_game"):

				if current_target.has_method("interact"):

					print("게임 시작:", current_target.name)

					current_target.interact()


func _physics_process(delta):

	if not can_move:

		velocity = Vector2.ZERO

		sprite.play(last_direction + " idle")

		move_and_slide()

		return


	var direction = Vector2.ZERO


	if Input.is_action_pressed("moveright"):
		direction.x += 1

	if Input.is_action_pressed("moveleft"):
		direction.x -= 1

	if Input.is_action_pressed("movedown"):
		direction.y += 1

	if Input.is_action_pressed("moveup"):
		direction.y -= 1


	velocity = direction.normalized() * SPEED

	move_and_slide()


	# =========================
	# 이동 애니메이션
	# =========================
	if direction != Vector2.ZERO:

		if direction.x > 0:

			if sprite.animation != "right":
				sprite.play("right")

			last_direction = "right"


		elif direction.x < 0:

			if sprite.animation != "left":
				sprite.play("left")

			last_direction = "left"


		elif direction.y > 0:

			if sprite.animation != "front":
				sprite.play("front")

			last_direction = "front"


		elif direction.y < 0:

			if sprite.animation != "back":
				sprite.play("back")

			last_direction = "back"


	else:

		var idle_anim = last_direction + " idle"

		if sprite.animation != idle_anim:
			sprite.play(idle_anim)


# =========================
# 감지 (Area2D 감지)
# =========================
func _on_area_2d_area_entered(area):

	if area.is_in_group("interactable"):

		current_target = area

		can_interact = true

		print("감지:", area.name)


func _on_area_2d_area_exited(area):

	if area == current_target:

		current_target = null

		can_interact = false

		print("감지 해제:", area.name)


# =========================
# 윤곽선
# =========================
func set_outline(enable):

	if sprite.material:

		if enable:
			outline_count += 1

		else:
			outline_count -= 1


		outline_count = max(outline_count, 0)


		if outline_count > 0:
			sprite.material.set("shader_parameter/outline_size", 2.0)

		else:
			sprite.material.set("shader_parameter/outline_size", 0.0)
