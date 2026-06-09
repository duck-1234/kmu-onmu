extends Area2D

func _on_area_entered(area):
	
	if area.is_in_group("pottery"):
		get_parent().failed_sorts += 1
		get_parent().update_ui()

		area.queue_free()
 
