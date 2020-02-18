extends "res://hero/state_machine.gd"

export var jump_acc = 160
export var jump_duration = 0.240
export var jump_min_duration = 0.160
export var jump_friction = 4
var flight_t : float
var jumping := false

func entry():
	.entry()
	
	jumping = false
	flight_t = 0
	
	if Input.is_action_pressed("ducking") and name != "duck":
		emit_signal("restate", "duck")
	
	if Input.is_action_pressed("sprint") and name != "sprint":
		emit_signal("restate", "sprint")

func proceed(dt):
	if not me.is_on_floor() and me.vel.y < 0:
		emit_signal("restate", "fall")
	
	if Input.is_action_pressed("jump") or (flight_t < jump_min_duration and jumping):
		jumping = true
		if flight_t >= jump_duration:
			emit_signal("restate", "fall")
		flight_t += dt
		me.vel += jump_friction * -me.vel * dt
		me.vel.y += jump_acc * dt   # Intended Movement Force
		