extends RigidBody2D


func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		Global.add_points(area.points)
		area.set_explosion()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.get_class() == "TileMap":
		queue_free()
