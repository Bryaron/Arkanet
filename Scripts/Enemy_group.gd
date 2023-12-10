extends Path2D

@export var speed:float = 200
@onready var recorridos:Array[Node] = get_children()

var is_in_screen = false

func _physics_process(delta):
	if is_in_screen:
		for recorrido in recorridos:
			if recorrido.get_class() == "PathFollow2D":
				recorrido.progress += speed*delta

func _on_visible_on_screen_enabler_2d_screen_entered():
	is_in_screen = true
