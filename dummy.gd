extends Area2D
@onready var result_panel = $"../CanvasLayer/ResultPanel"
@onready var result_label = $"../CanvasLayer/ResultPanel/ResultLabel"
@onready var hit_label = $"../CanvasLayer/Label"

func _on_body_entered(body):

	if body.name == "Spear":

		hit_label.visible = true

		body.reset_spear()

		await get_tree().create_timer(1.0).timeout

		hit_label.visible = false
		
		print("hit")
		result_panel.visible = true

		result_label.text = str(body.try_count) + "번 만에 성공!"


func _on_button_pressed() -> void:

	GameData.clear_artifact("chang_game")

	if GameData.artifact_count >= 5:
		get_tree().change_scene_to_file("res://ending.tscn")
	else:
		get_tree().change_scene_to_file("res://map1.tscn")
