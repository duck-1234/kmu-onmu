extends Area2D

@export var correct_rotation := 0

var mouse_inside := false
var is_locked := false


func _ready():
	add_to_group("puzzle")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# 시작 랜덤 회전 (원하면 제거 가능)
	rotation_degrees = [0, 90, 180, 270].pick_random()


func _on_mouse_entered():
	mouse_inside = true


func _on_mouse_exited():
	mouse_inside = false


func _input(event):
	if is_locked:
		return

	if mouse_inside and event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:

			print("클릭됨")

			#  회전 (float 문제 방지)
			rotation_degrees = fmod(rotation_degrees + 90.0, 360.0)

			#  시도 횟수 증가
			get_tree().call_group("puzzle_manager", "add_try")

			#  클리어 체크
			get_tree().call_group("puzzle_manager", "check_clear")


func _on_button_pressed() -> void:

	GameData.clear_artifact("jimsung_giwa")

	if GameData.artifact_count >= 5:
		get_tree().change_scene_to_file("res://ending.tscn")
	else:
		get_tree().change_scene_to_file("res://map1.tscn")
