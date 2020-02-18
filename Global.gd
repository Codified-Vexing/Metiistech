extends Node

var scrn
var hero
var paused = false setget _to_pause

class axle:
	var pos
	var neg
	func _init(p,n):
		pos = p
		neg = n
	func now():
		return int(Input.is_action_pressed(pos)) - int(Input.is_action_pressed(neg))
		
func unique(iterable):
	var memory = []
	for each in iterable:
		if not memory.has(each):
			memory.append(each)
	return memory
		
func _to_pause(what):
	if what:
		paused = true
#		pause_mode(PAUSE_MODE_STOP)
	else:
		paused = false
#		pause_mode(PAUSE_MODE_PROCESS)

func at_hero_coord(offset=Vector3(0,0,0)):
	var output = hero.translation - offset.rotated(Vector3(0,1,0),hero.rotation.y)
	return output
