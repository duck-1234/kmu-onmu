extends Node2D

@export var pottery_scene: PackedScene
@export var obstacle_scene: PackedScene

var displayed_artifacts := 0
var sorted_obstacles := 0
var failed_sorts := 0

var current_item = null
var game_over := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	randomize()

	$GameTimer.wait_time = 30
	$GameTimer.start()

	$SpawnTimer.start()

	$Panel.visible = false

	update_ui()

func _process(delta):

	$UI/Control/TimeBar.max_value = 30
	$UI/Control/TimeBar.value = $GameTimer.time_left

	$UI/Control/TimerLabel.text = str(
		int(ceil($GameTimer.time_left))
	)

	if $GameTimer.time_left <= 0:
		$UI/Control/TimeBar.hide()

func update_ui():

	$UI/Control/ArtifactLabel.text = "전시 유물 : %d" % displayed_artifacts

	$UI/Control/ObstacleLabel.text = "장애물 : %d" % sorted_obstacles

	$UI/Control/MissLabel.text = "실패 : %d" % failed_sorts

func _on_spawn_timer_timeout():

	if game_over:
		return

	var item

	# 70% 유물, 30% 장애물
	if randf() < 0.7:
		item = pottery_scene.instantiate()
	else:
		item = obstacle_scene.instantiate()

	item.position = $SpawnPoint.position

	$Item.add_child(item)

	$SpawnTimer.wait_time = randf_range(0.4, 1.2)
	$SpawnTimer.start()

func _on_game_timer_timeout():

	

	if game_over:
		return

	game_over = true

	$SpawnTimer.stop()
	$UI.hide()

	$Item.hide()

	show_result()

	show_result()

func show_result():

	$Panel.visible = true

	var total_score = displayed_artifacts * 100
	
	$Panel/TitleLabel.text = "김천 송죽리 신석기 시대 도자기"
	
	$Panel/ArtifactResult.text = "전시된 유물 : %d" % displayed_artifacts

	$Panel/ObstacleResult.text = "잘못 전시된 장애물 : %d" % sorted_obstacles

	$Panel/MissResult.text = "실패 : %d" % failed_sorts



func _on_failzone_area_exited(area: Area2D) -> void:
	pass # Replace with function body.


func _on_failzone_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_retry_button_pressed() -> void:

	GameData.clear_artifact("dojagicatch")

	if GameData.artifact_count >= 5:
		get_tree().change_scene_to_file("res://ending.tscn")
	else:
		get_tree().change_scene_to_file("res://map2.tscn")
