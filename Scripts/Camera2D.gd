extends Camera2D

@export var speed:int = 400

func _physics_process(delta):
	if !Global.cinematic:
		position.x += speed*delta
