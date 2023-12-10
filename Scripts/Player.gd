extends CharacterBody2D

@export var speed:int = 600

@onready var shot:PackedScene = preload("res://Scenes/Shot.tscn")
@onready var specialShot = preload("res://Scenes/Special_shot.tscn")
@onready var HUD:CanvasLayer = get_tree().get_nodes_in_group("hud")[0]
@onready var playback:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

var motion:Vector2 = Vector2(0, 0)
var cooldown:bool = true
var powerUp:bool = false

func _ready():
	Global.lifes = 3
	Global.labelPoints = HUD.get_node("PointsBar/Label")

func _physics_process(delta):
	if !Global.cinematic:
		get_inputs()
		move_and_slide()
		if is_on_wall():
			take_damage()
	
	#print(playback.get_current_node())
	#print(motion)
	#print(velocity)

func get_inputs():
	motion = Vector2(0, 0)
	
	var dirY:float = Input.get_axis("move_up","move_down")
	var dirX:float = Input.get_axis("move_left","move_right")
	
	if Input.is_action_pressed("move_right"):
		motion.x = dirX 
		playback.travel("move_right")
	if Input.is_action_pressed("move_left"):
		motion.x = dirX 
		playback.travel("move_left")
	if Input.is_action_pressed("move_up"):
		motion.y = dirY 
	if Input.is_action_pressed("move_down"):
		motion.y = dirY 
	if Input.is_action_pressed("attack"):
		Shot()
	if motion == Vector2(0, 0):
		#$AnimationPlayer.play("RESET")
		playback.travel("RESET")
		
	#motion = Vector2(dirX, dirY)
	velocity = motion * speed
	
func Shot():
	if cooldown:
		cooldown = false
		$Timer.start()
		$AudioStreamPlayer.play()
		var shot_instance
		if powerUp:
			shot_instance = specialShot.instantiate()
		else:
			shot_instance = shot.instantiate()
		shot_instance.global_position = $ShotPos.global_position
		get_tree().root.add_child(shot_instance)
		
func take_damage():
	Global.remove_life()
	var life_bar:TextureRect = HUD.get_node("LifeBar")
	var lifes:Array[Node] = life_bar.get_children()
	lifes[Global.lifes].visible = false
	$DamageAnim.play("take_damage")

func _on_timer_timeout():
	cooldown = true
	pass
	

func _on_area_2d_area_entered(area):
	if (area.is_in_group("enemy")):
		take_damage()
		area.set_explosion()
	pass
