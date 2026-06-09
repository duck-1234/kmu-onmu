extends Node2D

@onready var bubble = $Malpungsun
@onready var label = $Label
@onready var timer = $DialogueTimer

var dialogues = [
	"여기는 특별 전시관인가?",
	"테마별로 바뀌는 전시관이라니!\n배우 흥미롭군",
	"하지만 들리는 소리는 없는듯 하군",
	"[To Be continued]"
]

var current_dialogue = 0
var current_char = 0
var typing = true

func _ready():
	bubble.visible = true
	label.visible = true
	label.text = ""

	timer.wait_time = 0.1
	timer.start()

func _on_dialogue_timer_timeout():
	if typing:
		var text = dialogues[current_dialogue]

		if current_char < text.length():
			label.text += text[current_char]
			current_char += 1
		else:
			typing = false
			timer.wait_time = 0.5

	else:
		current_dialogue += 1

		if current_dialogue >= dialogues.size():
			get_tree().change_scene_to_file("res://mainmap.tscn")
			return

		label.text = ""
		current_char = 0
		typing = true
		timer.wait_time = 0.1
