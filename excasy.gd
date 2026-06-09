extends Node2D

@onready var bubble = $Malpungsun
@onready var label = $Label
@onready var timer = $DialogueTimer

var dialogues = [
	"안녕, 우리는 돌낫과 홈자귀",
	"우리가 발굴 되었던 것 처럼\n우리도 다른 유물에게\n도움을 주고 싶어",
	"나 돌낫은 1번을 눌러 장착하고\n정밀한 조작이 가능해",
	"나 홈자귀, 2번으로 장착하고\n넓은 타격을 하지",
	"우리로 유물들을 도와줘!"
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
			get_tree().change_scene_to_file("res://excavation.tscn")
			return

		label.text = ""
		current_char = 0
		typing = true
		timer.wait_time = 0.1
