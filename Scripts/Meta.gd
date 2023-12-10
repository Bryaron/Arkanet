extends AnimatedSprite2D

@onready var player:CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@export_file("*.tscn") var nextLevel

func cinematic():
	Global.cinematic = true;
	
	var tween:Tween = create_tween()
	#var player_position = player.global_position
	var antenna_position = $AntennaPosition.global_position
	var exit_position = $ExitPosition.global_position
	
	tween.tween_property(player,"global_position", antenna_position, 2)
	await tween.finished
	$AnimationPlayer.play("meta")
	await $AnimationPlayer.animation_finished
	var tween2:Tween = create_tween()
	tween2.tween_property(player, "global_position", exit_position, 2)
	await tween2.finished
	Global.cinematic = false
	get_tree().change_scene_to_file(nextLevel)
	
	
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	cinematic()
