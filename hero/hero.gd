extends KinematicBody

## This Node needs to be the first one to be instantiated in the tree.

onready var state_stack: Array
# warning-ignore:unused_class_variable
onready var tween = $Tween

var grav = ProjectSettings.get_setting("physics/3d/default_gravity")
var grav_dir = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

# warning-ignore:unused_class_variable
onready var part = {
					"eyes": $hips/head/Camera,
					"collider": $CollisionShape,
					}

var ahead = GLOB.axle.new("backward", "forward")
var strafe = GLOB.axle.new("rightward", "leftward")

var vel = Vector3()
var dir
var state = {}

export var max_slope = 0.78  # How steep of an inclination angle the character can still walk on.

func _ready():
	GLOB.hero = self
	
	var path = "res://hero/states/"
	var folder = Directory.new()
	var file = "fall.gd"
	var stt
	folder.open(path)
	folder.list_dir_begin(true, true)
	
	while file != "":
		stt = load(path + file).new()
		stt.me = self
		stt._ready()  # It isn't running this by itself for some reason
		stt.connect("restate", self, "state_change")
		state[stt.name] = stt
		
		file = folder.get_next()
	folder.list_dir_end()
	
	state_stack.append(state["walk"])
	
	state_stack[0].entry()

func state_change(which):
	
	state_stack[0].exit()
	
	if typeof(which) == TYPE_INT:
		for each in range(which):
			state_stack.pop_front()
	else:
		state_stack.push_front(state[which])

	state_stack[0].entry()

	if len(state_stack) > 6:
		state_stack.pop_back()

func _physics_process(dt):
	dir = Vector3(strafe.now(), 0, ahead.now()).normalized().rotated(Vector3(0,1,0),rotation.y)
	
	state_stack[0].proceed(dt)
	
		# Facing direction relation to moving direction: str(rad2deg( abs(vel.slide(grav_dir).angle_to(Vector3(0,0,-1)) - abs(rotation.y)) ))
	
	vel += grav * grav_dir * dt * 10
	
	vel = move_and_slide(vel, Vector3(0,1,0), 0.05, 4, max_slope)
	
func _input(event):
	state_stack[0].react(event)
