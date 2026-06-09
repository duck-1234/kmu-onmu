extends Node2D

@onready var bubble = $Sprite2D3
@onready var label = $Label
@onready var dialogue_timer = $DialogueTimer

var dialogues = ["나는 유물의 생각을 들을 수 있다.",
	"나는 유물의 생각을 들을 수 있다.",
	"유물들의 한을 들어주면 유물의 기가 강해진다.",
	"나의 직업은 각종 박물관의 부탁을 받아 이 한을 \n 풀어주는 것이다."
]

var current_dialogue := 0
var current_char := 0
var typing := false

func _ready():
	bubble.visible = false
	label.visible = false

func _on_start_timer_timeout():
	print("시작 ")
	bubble.visible = true
	label.visible = true

	start_dialogue()

func start_dialogue():
	label.text = ""
	current_char = 0
	typing = true

	dialogue_timer.wait_time = 0.1 # 글자 나오는 속도
	dialogue_timer.start()

func _on_dialogue_timer_timeout():
	var text = dialogues[current_dialogue]

	if typing:
		if current_char < text.length():
			label.text += text[current_char]
			current_char += 1
		else:
			typing = false
			dialogue_timer.wait_time = 2.0 # 대사 다 나온 후 2초 대기
	else:
		current_dialogue += 1

		if current_dialogue >= dialogues.size():
			dialogue_timer.stop()
			get_tree().change_scene_to_file("res://startstory.tscn")
			return

		start_dialogue()
