extends Area2D

var current_item = null

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.animation_finished.connect(_on_animation_finished)

func _input(event):
	if event.is_action_pressed("ui_accept"):

		anim.play("catch")

		if current_item != null:

			if current_item.is_in_group("obstacle"):
				get_parent().sorted_obstacles += 1
			else:
				get_parent().displayed_artifacts += 1

			current_item.queue_free()
			current_item = null

			get_parent().update_ui()

func _on_animation_finished():
	if anim.animation == "catch":
		anim.play("default")

func _on_area_entered(area):
	current_item = area

func _on_area_exited(area):
	if current_item == area:
		current_item = null


func _on_failzone_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_failzone_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
