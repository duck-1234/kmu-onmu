extends Node2D

@onready var cursor = $"../ToolCursor"

var selected_tool = "stone_sickle"

var stone_texture = preload("res://digger/dolnot.png")
var chisel_texture = preload("res://digger/homjagui.png")

func _ready():

	if cursor:
		cursor.texture = stone_texture

func _input(event):

	if event.is_action_pressed("tool1"):

		selected_tool = "stone_sickle"

		if cursor:
			cursor.texture = stone_texture

	if event.is_action_pressed("tool2"):

		selected_tool = "chisel"

		if cursor:
			cursor.texture = chisel_texture

func use_tool(pos:Vector2i):

	var gm = get_tree().current_scene.get_node_or_null("digGameManager")

	if gm == null:
		return
	gm.click_count += 1
	
	match selected_tool:

		"stone_sickle":
			gm.stone_sickle(pos)

		"chisel":
			gm.chisel(pos)
