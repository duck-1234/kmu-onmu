extends Area2D

@export var target_scene : String

func _ready():
	add_to_group("door")

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.can_interact = true
		body.current_target = self

func _on_body_exited(body):
	if body is CharacterBody2D:
		body.can_interact = false
		body.current_target = null

func interact():
	get_tree().change_scene_to_file(target_scene)
