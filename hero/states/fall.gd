extends "res://hero/state_machine.gd"

export var trans_acc = 10

func proceed(dt):
	if me.is_on_floor():
		if me.state_stack[1].name=="jump":
			emit_signal("restate", me.state_stack[2].name)
		else:
			emit_signal("restate", "walk")
		
	me.vel += trans_acc * me.dir * dt   # Intended Movement Force
