extends Area2D

@export var speed:int = 500
@export var points:int = 100

@onready var player:Array[Node] = get_tree().get_nodes_in_group("player")
@onready var is_in_screen = false

func _physics_process(delta):
	if is_in_screen:
		var position_player:Vector2 = player[0].global_position
		global_position = global_position.move_toward(position_player, delta * speed)
	
func set_explosion():
	collision_mask = 0
	collision_layer = 0
	$AnimatedSprite2D.animation = "Explosion"
	$AudioStreamPlayer.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();


func _on_visible_on_screen_notifier_2d_screen_entered():
	is_in_screen = true
