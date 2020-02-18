extends Node

var land

# Physical Attributes
var temperature := 0.0
var illumination := 0.0
var radiation := 0.0
var ergo := 0.0
var mech := 0.0
var flow := Vector3(0,0,0)
var variant := 0
var is_solid := true

var recipe = null

class ingredient:
	var shapeless = false
	var amount = 1
	var name = "notch"
	
	func _init(n, s, a):
		name = n
		shapeless = s
		amount = a

func _ready():
	name = get_script().get_path().get_file().trim_suffix(".gd")

func spawn(coord):
	return false
