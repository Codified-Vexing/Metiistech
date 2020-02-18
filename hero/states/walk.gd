extends "res://hero/states/on_floor.gd"

export var trans_acc = 40
export var friction_acc = 6


func proceed(dt):
	.proceed(dt)
	if not jumping:
		me.vel += friction_acc * -me.vel * dt  # Friction 
	me.vel += trans_acc * me.dir * dt   # Intended Movement Force

func react(ev):
	.react(ev)
	
	if ev.is_action_pressed("ducking"):
		emit_signal("restate", "duck")
	
	if ev.is_action_pressed("sprint"):
		emit_signal("restate", "sprint")