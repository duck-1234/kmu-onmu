extends Node2D

@onready var left_bubble = $LeftBubble
@onready var right_bubble = $RightBubble

@onready var left_label = $LeftLabel
@onready var right_label = $RightLabel

@onready var left_char = $LeftCharacter
@onready var right_char = $RightCharacter

var current = 0

var dialogues = [
	{
		"side":"left",
		"text":"오오 당신은 \n부탁드렸던 Foresighter!"
	},
	{
		"side":"right",
		"text":"관리자분 안녕하세요 "
	},
	{
		"side":"left",
		"text":"저희 유물들 의뢰는\n 잘 해결되었나요!"
	},
	{
		"side":"right",
		"text":"잘 해결되었습니다\n박물관 입구부터 기가\n느껴지는군요"
	},
	{
		"side":"left",
		"text":"오오 감사합니다"
	},
	{
		"side":"right",
		"text":"그나저나 테마별로 바뀌는\n학교안 박물관이라니\n흥미롭더군요"
	},
	{
		"side":"right",
		"text":"그럼 기회가 된다면 \n다시 봅시다. "
	}
]

func _ready():
	show_dialogue()

func show_dialogue():

	left_bubble.visible = false
	right_bubble.visible = false

	left_label.visible = false
	right_label.visible = false

	var d = dialogues[current]

	if d.side == "left":
		left_bubble.visible = true
		left_label.visible = true
		left_label.text = d.text

		left_char.modulate.a = 1.0
		right_char.modulate.a = 0.4

	else:
		right_bubble.visible = true
		right_label.visible = true
		right_label.text = d.text

		left_char.modulate.a = 0.4
		right_char.modulate.a = 1.0
func _unhandled_input(event):

	if event.is_action_pressed("ui_accept") \
	or event.is_action_pressed("click"):

		current += 1

		if current >= dialogues.size():
			GameData.reset_game()
			# 엔딩 끝
			get_tree().change_scene_to_file("res://Opning.tscn")
			return

		show_dialogue()
