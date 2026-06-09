extends Node2D

@onready var bubble = $Malpungsun
@onready var label = $Label
@onready var timer = $DialogueTimer

var dialogues = [
	"우리는 김천 송죽리 \n신석기 시대 도자기 모둠!",
	"우리는 하늘을 \n날아보고 싶어!",
	"우리가 깨지지 않게 \nspace를 눌러 잘 받아줘",
	"우리는 폐쇠적이라 도자기가 \n아닌 다른 물건은 반기지 않아 "
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
			get_tree().change_scene_to_file("res://dojagicatch.tscn")
			return

		label.text = ""
		current_char = 0
		typing = true
		timer.wait_time = 0.1
