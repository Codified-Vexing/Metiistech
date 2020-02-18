extends Camera

onready var look = Cam_Control.new(get_node(".."), get_node("../../.."), get_node("../.."))

var base_fov : float

export var mouse_sensitivity = 2.5

class Cam_Control:
	
	var maxi = Vector3(90,90,90)
	var mini = Vector3(90,90,90)
	var out
	var tgt = {"x":null,"y":null,"z":null,}
	
	func _init (pit=null, yaw=null, rol=null):
		
		# Which nodes are driven for a certain rotation
		tgt["x"] = pit
		tgt["y"] = yaw
		tgt["z"] = rol
		
	func pit(angle):
		out = tgt["x"].get_rotation() + Vector3(angle, 0, 0)
		out.x = deg2rad(clamp(rad2deg(out.x),mini.x,maxi.x))
		tgt["x"].set_rotation(out)
		tgt["x"].orthonormalize()
		
	func yaw(angle):
		out = tgt["y"].get_rotation() + Vector3(0, angle, 0)
		out.y = deg2rad(wrapf(rad2deg(out.y),0,360))
		tgt["y"].set_rotation(out)
		tgt["y"].orthonormalize()
	
	func rol(angle):
		out = Vector3(0, 0, angle)
		out.z = deg2rad(wrapf(rad2deg(out.z),0,360))
		tgt["z"].set_rotation(out)
		tgt["z"].orthonormalize()
	
	func xy(angle = Vector2()):
		self.pit(angle.x/2)
		self.yaw(angle.y/2)
		
func _ready():
	set_process_input(true)
	
	base_fov = fov
	
	look.maxi = Vector3(88,0,0)
	look.mini = Vector3(-85,0,0)
	
func _input(ev):
	if ev is InputEventMouseMotion:
		# $Camera.fov
		look.xy(Vector2(deg2rad(-ev.relative.y/mouse_sensitivity),deg2rad(-ev.relative.x/mouse_sensitivity)))
