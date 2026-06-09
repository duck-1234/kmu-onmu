extends Area2D

@export var cell_pos : Vector2i

@onready var sprite = $Sprite2D

var layer := 3

var stone_tex = preload("res://digger/stone.png")
var gravel_tex = preload("res://digger/gravel.png")
var dirt_tex = preload("res://digger/dirt.png")

func _ready():

	update_sprite()

	var gm = get_tree().current_scene.get_node_or_null("digGameManager")

	if gm:
		gm.register_cell(self)

func damage(amount:int):

	layer = max(layer - amount, 0)

	update_sprite()

	if layer == 0:

		var gm = get_tree().current_scene.get_node_or_null("digGameManager")

		if gm:
			gm.check_artifact(cell_pos)

func update_sprite():

	match layer:

		3:
			sprite.texture = stone_tex

		2:
			sprite.texture = gravel_tex

		1:
			sprite.texture = dirt_tex

		0:
			visible = false
			input_pickable = false

func _input_event(_viewport, event, _shape_idx):

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed:

				var tm = get_tree().current_scene.get_node_or_null("ToolManager")

				if tm:
					tm.use_tool(cell_pos)
