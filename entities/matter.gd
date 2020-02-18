var name

# These attributes should be supplied when instancing this script
var land  # The terrain generator
var given  # The material object

# Physical Attribute
var form = 0  # what state of matter it is
var pattern = 0  # The currently picked engraving
var coloring = 0  # The current colour variant
var orientation # I dunno yet
var temperature := 0.0
var illumination := 0.0
var radiation := 0.0
var ergo := 0.0
var mech := 0.0
var flow := Vector3(0,0,0)
var variant := 0

var recipe = null

class ingredient:
	var shapeless = false
	var amount = 1
	var name = "notch"
	
	func _init(n, s, a):
		name = n
		shapeless = s
		amount = a

func _init(terrain, material):
	land = terrain
	given = material
	name = given.get_script().get_path().get_file().trim_suffix(".gd")

func curr_form():
	return given.forms[form]
func curr_color():
	return given.colors[coloring]


func spawn(coord):
	return false
	
