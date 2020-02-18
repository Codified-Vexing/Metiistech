extends "res://hero/state_machine.gd"

export var trans_acc = 150
var time : float
	
func entry():
	.entry()
	time = 0

func proceed(dt):
	if time >= 0.205:
		emit_signal("restate", "fall")
	else:
		time += dt
	
	me.vel.y += trans_acc * dt   # Intended Movement Force
