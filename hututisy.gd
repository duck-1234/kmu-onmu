extends Node2D

@onready var bubble = $Malpungsun
@onready var label = $Label
@onready var timer = $DialogueTimer

var dialogues = [
	"안녕 나는 후투티\n여기 계명대학교의 마스코트이자\n교조를 담당하지 ",
	"나의 귀여움을 사진으로 남기고 싶어\n옆에 사진기로 나를 찍어줘"
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
			get_tree().change_scene_to_file("res://map3.tscn")
			return

		label.text = ""
		current_char = 0
		typing = true
		timer.wait_time = 0.1
