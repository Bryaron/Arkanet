extends Node

var points:int = 0
var lifes:int = 3
var labelPoints:Label
var cinematic = false

func remove_life():
	print("Vidas: "+ str(lifes))
	if lifes > 1:
		lifes -= 1
	else:
		Global.cinematic = false
		get_tree().reload_current_scene()
	#print("Vidas: "+ str(lifes))
	
func add_points(value:int):
	points += value
	labelPoints.text = str(points)
