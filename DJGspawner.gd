extends Node

@export var pottery_scene : PackedScene
@export var obstacle_scene : PackedScene

@onready var spawn_point = $"../SpawnPoint"
@onready var items = $"../Item"

var game_over = false

func spawn_item():

	if game_over:
		return

	var item

	if randf() < 0.7:
		item = pottery_scene.instantiate()
	else:
		item = obstacle_scene.instantiate()

		# 장애물만 크기 조절
		item.scale = Vector2(0.05, 0.05)

	item.position = spawn_point.position

	items.add_child(item)
