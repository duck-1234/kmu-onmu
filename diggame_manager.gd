extends Node

var start_time : float
var click_count := 0

@onready var found_label = $"../UI/FoundLabel"

@onready var clear_panel = $"../UI/ClearPanel"
@onready var time_label = $"../UI/ClearPanel/TimeLabel"
@onready var click_label = $"../UI/ClearPanel/ClickLabel"

var cells = {}

var artifacts = {}
var found_count = 0


func _ready():
	start_time = Time.get_ticks_msec() / 1000.0

	found_label.visible = false
	clear_panel.visible = false

	artifacts = {
		Vector2i(2, 1): false,
		Vector2i(1, 3): false,
		Vector2i(7, 1): false
	}

	found_count = 0

	print("유물 위치:", artifacts)

func register_cell(cell):

	cells[cell.cell_pos] = cell

func damage_cell(pos:Vector2i, amount:int):

	if cells.has(pos):

		cells[pos].damage(amount)

func stone_sickle(pos:Vector2i):

	damage_cell(pos, 2)

func chisel(pos:Vector2i):

	var dirs = [
		Vector2i.ZERO,
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT
	]

	for d in dirs:

		damage_cell(pos + d, 1)

func check_artifact(pos:Vector2i):

	if artifacts.has(pos):

		if artifacts[pos] == false:

			artifacts[pos] = true

			found_count += 1

			print("유물 발견!", pos)

			print("발견 수:", found_count, "/3")

			if found_count >= 3:

				clear_game()
				
func show_found_text():

	found_label.visible = true
	found_label.text = "유물 발견!"

	await get_tree().create_timer(1.5).timeout

	found_label.visible = false
	
func clear_game():

	var clear_time = Time.get_ticks_msec() / 1000.0 - start_time

	time_label.text = "걸린 시간 : %.1f초" % clear_time
	click_label.text = "클릭 횟수 : %d회" % click_count

	clear_panel.visible = true
	
func _on_button_pressed() -> void:

	GameData.clear_artifact("excavation")

	if GameData.artifact_count >= 5:
		get_tree().change_scene_to_file("res://ending.tscn")
	else:
		get_tree().change_scene_to_file("res://map2.tscn")
