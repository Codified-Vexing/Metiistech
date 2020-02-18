extends "res://hero/states/on_floor.gd"

export var trans_acc = 10
export var friction_acc = 6

func entry():
	.entry()
	me.part["collider"].shape.height = 0.4
	me.part["collider"].translation.y += 0.8
	
func proceed(dt):
	me.vel += friction_acc * -me.vel * dt  # Friction 
	me.vel += trans_acc * me.dir * dt   # Intended Movement Force
	
func react(ev):
	.react(ev)
	if ev.is_action_released("ducking"):
		emit_signal("restate", "walk")
		
func exit():
	me.part["collider"].shape.height = 1
	me.translation.y += 1
	me.part["collider"].translation.y -= 0.8