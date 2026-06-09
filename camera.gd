extends Node2D

@export var bird_scene: PackedScene
@onready var result_panel = $"ResultPanel"

var success_count := 0
var partial_count := 0
var fail_count := 0

var time_left := 30
var can_shoot := true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update_ui()

func _input(event):
	if event.is_action_pressed("shoot"):
		take_photo()

func take_photo():

	print("take_photo 실행")

	if !can_shoot:
		return

	can_shoot = false

	flash_effect()
	
	check_photo()

	await get_tree().create_timer(0.5).timeout

	can_shoot = true

func flash_effect():

	print("현재 노드:", self.name)

	var flash = get_node_or_null("Flash")

	print("flash =", flash)

	if flash == null:
		return

	flash.visible = true

	await get_tree().create_timer(0.08).timeout

	flash.visible = false

func check_photo():

	var result := "fail"

	for bird in $Bird.get_children():

		var body = bird
		var center = bird.get_node_or_null("CenterArea")

		if center == null:
			continue

		print("bird pos:", bird.global_position)
		print("center pos:", center.global_position)
		print("frame pos:", $CameraFrame.global_position)

		print("center:", center.overlaps_area($CameraFrame))
		print("body:", body.overlaps_area($CameraFrame))

		if center.overlaps_area($CameraFrame) and body.overlaps_area($CameraFrame):
			result = "success"
			break

		elif center.overlaps_area($CameraFrame) or body.overlaps_area($CameraFrame):
			result = "partial"

	print("최종 결과:", result)

	match result:
		"success":
			success_count += 1
		"partial":
			partial_count += 1
		"fail":
			fail_count += 1

	update_ui()
func spawn_bird():

	var bird = bird_scene.instantiate()

	bird.position = Vector2(
		randf_range(150, 1575),
		randf_range(150, 762)
	)

	$Bird.add_child(bird)


func update_ui():

	$UI/SuccessLabel.text = "성공 : %d" % success_count
	$ResultPanel/SuccessLabel.text = "성공 : %d" % success_count
	$UI/PartialLabel.text = "잘림 : %d" % partial_count
	$ResultPanel/PartialLabel.text = "잘림 : %d" % partial_count
	$UI/FailLabel.text = "실패 : %d" % fail_count
	$ResultPanel/FailLabel.text = "실패 : %d" % fail_count
	$UI/TimeLabel.text = str(time_left)


func _on_spawn_timer_timeout():
	spawn_bird()


func _on_game_timer_timeout():

	time_left -= 1

	update_ui()

	if time_left <= 0:
		end_game()


func end_game():

	$SpawnTimer.stop()
	$GameTimer.stop()

	print("촬영 종료")
	print("성공 :", success_count)
	print("잘림 :", partial_count)
	print("실패 :", fail_count)

	result_panel.visible = true
	
	$UI.visible = false

func _on_button_pressed() -> void:

	GameData.clear_artifact("cam")

	if GameData.artifact_count >= 5:
		get_tree().change_scene_to_file("res://ending.tscn")
	else:
		get_tree().change_scene_to_file("res://map3.tscn")
