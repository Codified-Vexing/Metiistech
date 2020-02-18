extends "res://hero/states/on_floor.gd"

export var trans_acc = 40
export var friction_acc = 3

func entry():
	.entry()
	if Input.is_action_pressed("forward"):
		me.tween.interpolate_property(me.part["eyes"], "fov", null, me.part["eyes"].base_fov-12, 0.25, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
		me.tween.start()

func proceed(dt):
	.proceed(dt)
	if not jumping:
		me.vel += friction_acc * -me.vel * dt  # Friction 
	me.vel += trans_acc * me.dir * dt   # Intended Movement Force

func exit():
	if not jumping:
		me.tween.interpolate_property(me.part["eyes"], "fov", null, me.part["eyes"].base_fov, 1, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
		me.tween.start()

func react(ev):
	.react(ev)
	
	if ev.is_action_released("sprint"):
		emit_signal("restate", "fall")
	
	if ev.is_action_pressed("forward"):
		me.tween.interpolate_property(me.part["eyes"], "fov", null, me.part["eyes"].base_fov-12, 0.25, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
		me.tween.start()
	
	if ev.is_action_released("forward"):
		me.tween.interpolate_property(me.part["eyes"], "fov", null, me.part["eyes"].base_fov, 1, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
		me.tween.start()