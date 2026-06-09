extends Node2D

@onready var bubble = $Malpungsun
@onready var label = $Label
@onready var timer = $DialogueTimer

var dialogues = [
	"우리는 창과 갑옷!",
	"나 창병! 무언가를 피격해 보고 싶어!",
	"나 갑옷! 무언가를 막아보고 싶어!",
	"마우스를 이용해 \n나를 던져서 갑옷을 명중시켜줘!"
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
			timer.wait_time = 0.3

	else:
		current_dialogue += 1

		if current_dialogue >= dialogues.size():
			get_tree().change_scene_to_file("res://chang_game.tscn")
			return

		label.text = ""
		current_char = 0
		typing = true
		timer.wait_time = 0.1
