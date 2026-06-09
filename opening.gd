extends Node2D

# 시작 시 실행
func _ready() -> void:
	pass

# 매 프레임 실행
func _process(delta: float) -> void:
	pass


# Door에서 처리하므로 Opening에서는 사용 안함
func _on_area_2d_area_entered(area: Area2D) -> void:
	pass


func _on_door_body_exited(body: Node2D) -> void:
	pass


func _on_door_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
