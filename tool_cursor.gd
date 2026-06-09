extends Sprite2D

@export var follow_mouse := true

func _ready():

	# 기본 마우스 커서 숨기기
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta):

	if follow_mouse:
		global_position = get_global_mouse_position()


func set_tool_texture(texture_file: Texture2D):

	texture = texture_file
