extends Node

@onready var panel = $"../UI/Panel"
@onready var clear_label = $"../UI/Panel/ClearLabel"
@onready var try_label = $"../UI/Panel/TryLabel"

var cleared = false
var try_count = 0


func _ready():
	add_to_group("puzzle_manager")
	panel.visible = false
	update_ui()


# 👉 퍼즐 클릭 시 호출됨
func add_try():
	try_count += 1
	update_ui()


func update_ui():
	try_label.text = "시도 횟수: " + str(try_count)


func check_clear():
	if cleared:
		return

	var pieces = get_tree().get_nodes_in_group("puzzle")
	var clear = true

	for piece in pieces:
		var current = int(round(piece.rotation_degrees)) % 360

		if current != piece.correct_rotation:
			clear = false
			break

	if clear:
		cleared = true
		on_clear()


func on_clear():
	print("퍼즐 성공 🎉")

	panel.visible = true
	clear_label.text = "CLEAR!"
	update_ui()

	# 모든 퍼즐 잠금
	var pieces = get_tree().get_nodes_in_group("puzzle")
	for p in pieces:
		p.is_locked = true
