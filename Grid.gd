extends Node

var size = 0.43
var sea_level = 60  # the world Y coordinates go from -sea_level to 256-sea_level.

func _ready():
	var root = get_tree().get_root()

func place(obj, pos=Vector3(0,6,0), mode="REPLACE"):
	pos *= size
	match mode:
		"REPLACE":
			# Replace with overlapping block
			obj.translation = pos
		"ONTO":
			# Move Y upward until empty space is found
			pass
		"LAZY", _:
			# Fail to place if overlaps with existing block
			pass
