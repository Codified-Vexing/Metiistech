extends Node
# This script (and those that extend from it) define the constants that equally
# to all instances of a material.

var types = [
	"dropped",  # as an hovering icon
	"fabric",  # a bidimentional flexible sheet
	"wire",  # an unidimentional line following a parabola or bezier curve path between two points
	"powder",  # something like redstone
	"fluid",  # it spreads around the terrain
	"block",  # a 0.8 units wide cube
	"notch",  # a 0.4 units wide cube
	"nook",  # a 0.2 units wide cube
	"slab",  # a 0.8x0.8x0.4 parallelopiped
	"panel",  # a 0.8x0.8x0.2 parallelopiped
	"sheet",  # a 0.8x0.8x0.1 parallelopiped
	"facade",  # a 0.8x0.8x0.4 parallelopiped with a hole that can conceal other types
	"frame",  # a 0.8x0.8x0.2 parallelopiped with a hole that can conceal other types
	"pillar",  # a 0.8x0.4x0.4 parallelopiped
	"post",  # a 0.8x0.2x0.2 parallelopiped
	"stick",  # a 0.8x0.1x0.1 parallelopiped
	"plank",  # a 0.8x0.2x0.2 parallelopiped
	"brick",  # a 0.4x0.2x0.2 parallelopiped
	"plate",  # a 0.4x0.4x0.2 parallelopiped
]
const sides = ["top","bottom","east","west","north","south","other"]
var forms := []
var patterns = ["res://icon.png", ] # this should have a list of textures
var colors = [Color(ColorN("fuchsia")), ] # this should be a list of colours

var groups = []

var is_solid := true
var density := 1.1
var viscosity := 0.6
var stickiness := 0.1
var sonicDelay := 0.03
var ergoDelay := 0.01
var thermDelay := 0.5

var gasPoint := 400  # Temperature for it to vapourize
var freezePoint := -50  # Temperature until it turn solid
var pressEnergy := 100  # How much energy takes to press, turning it into powder, for example

class form:
	
	var vertices = []
	var faces = {"top":[],"bottom":[],"east":[],"west":[],"north":[],"south":[], "other":[]}
	var msh = Mesh.new()
	
	func _init(what):
		var st = SurfaceTool.new()
		st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
		for each in what["verts"]:
			st.add_vertex(each)
			vertices.append(each)
		for each in what["indx"]:
			for indx in what["indx"][each]:
				st.add_index(indx)
		faces = what["indx"]
		
		msh = st.commit()


func _ready():
	
	for each in groups:
		add_to_group(each)
	
	# turn form names into class instances
	# turn texture names into texture resources
	
	var path = "res://entities/forms/"
	var folder = Directory.new()
	var file = File.new()
	var filename
	folder.open(path)
	folder.list_dir_begin(true, true)
	filename = folder.get_next()
	
	while filename != "":
		file.open(path + filename, File.READ)
		var bundle = {"verts":[], "indx":{"top":[],"bottom":[],"east":[],"west":[],"north":[],"south":[], "other":[]}}
		var line = file.get_line()
		while line != "":
			if line.begins_with("vertices"):
				for each in line.lstrip("vertices").split(":"):
					var e = each.split_floats(",")
					e = Vector3( e[0],e[1],e[2] )
					bundle["verts"].append(e)
			
			if line.begins_with("indexes"):
				var part = line.lstrip("indexes").split(":")
				for side in range(sides.size()):
					var e = []
					var p = part[side].split(",")
					for n in p:
						if n!="":
							e.append(int(n))
					bundle["indx"][sides[side]] = e
			line = file.get_line()
		file.close()

		forms.append(form.new(bundle))
		filename = folder.get_next()
	folder.list_dir_end()
	

func drop():
	# When dropped from inventory.
	pass

func rotate():
	# Change the orientation of faces
	pass

func pickup():
	# When the material is picked by hand
	print("aye...")

func broke():
	# When the material is "mined" with a tool
	pass
