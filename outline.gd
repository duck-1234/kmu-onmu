extends Area2D
@export var target_scene : String
@onready var sprite = $Sprite2D

func _ready():
	add_to_group("game")
	if sprite.material:
		sprite.material = sprite.material.duplicate()
		sprite.material.set("shader_parameter/outline_size", 0.0)

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("enter")
		set_outline(true)
		if body is CharacterBody2D:
			body.can_interact = true
			body.current_target = self


func _on_body_exited(body):
	if body is CharacterBody2D:
		print("exit")
		set_outline(false)
	if body is CharacterBody2D:
		body.can_interact = false
		body.current_target = null	

func set_outline(enable):
	print("outline:", enable)

	if sprite.material:
		if enable:
			sprite.material.set("shader_parameter/outline_size", 3.0)
		else:
			sprite.material.set("shader_parameter/outline_size", 0.0)

func interact():
	get_tree().change_scene_to_file(target_scene)
	
