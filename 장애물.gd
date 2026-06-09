extends Area2D

@export var speed_x := 9000.0
@export var fall_gravity := 7000.0

var pottery_textures = [
	preload("res://2d겜프 에셋/apple.png"),
	preload("res://2d겜프 에셋/bomb.png"),
]

var velocity := Vector2.ZERO

func _ready():

	# 랜덤 도자기 선택
	var tex = pottery_textures.pick_random()
	$Sprite2D.texture = tex

	# 크기 랜덤 (선택사항)
	var scale_size = randf_range(2.5, 4.0)
	$Sprite2D.scale = Vector2(scale_size, scale_size)

	# 포물선 이동 시작
	velocity.x = speed_x
	velocity.y = -150.0

func _process(delta):

	# 중력 적용
	velocity.y += fall_gravity * delta

	# 이동
	position += velocity * delta

	# 화면 밖 삭제
	if position.x < -300:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
