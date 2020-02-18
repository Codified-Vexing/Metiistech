tool
extends StaticBody

var matter = {}
var mapping = []

var matterload = load("res://entities/matter.gd")

var WIDTH = 6
var HEIGHT = 2
var DEPTH = 6

var st = SurfaceTool.new()


func _ready():
	$surface.mesh = Mesh.new()
	
	var path = "res://entities/materials/"
	var folder = Directory.new()
	var filename
	folder.open(path)
	folder.list_dir_begin(true, true)
	filename = folder.get_next()
	while filename != "":
		var f = load(path+filename).new()
		f._ready()
		matter[filename.trim_suffix(".gd")] = f
		filename = folder.get_next()
	folder.list_dir_end()
	
	for x in range(WIDTH):
		mapping.append([])
		for y in range(HEIGHT):
			mapping[-1].append([])
			for z in range(DEPTH):
				var obj = matterload.new(self, matter["dirt"])
				mapping[-1][-1].append(obj)
		
	make_mesh()

func make_mesh():
	var terr_v = {}  # set vertex, get index
	var terr_i = []
	
	st.clear()
	st.begin(Mesh.PRIMITIVE_LINE_STRIP)
	
	for x in range(mapping.size()):
		for y in range(mapping[x].size()):
			for z in range(mapping[x][y].size()):
				var this = mapping[x][y][z]
				var atta = {
					"top": null, 
					"bottom": null,
					"east": null,
					"west": null,
					"north": null,
					"south": null,
					"other": null
				}

				if y+1 < mapping[x].size():
					atta["top"]=mapping[x][y+1][z]
				if y-1 >= 0:
					atta["bottom"]=mapping[x][y-1][z]
				if x-1 >= 0:
					atta["east"]=mapping[x-1][y][z]
				if x+1 < mapping.size():
					atta["west"]=mapping[x+1][y][z]
				if z+1 < mapping[x][y].size():
					atta["north"]=mapping[x][y][z+1]
				if z-1 >= 0:
					atta["south"]=mapping[x][y][z-1]

				if this == null:
					break

				var faces = this.curr_form().faces
				print(x,":",y,":",z)
				for f in faces:
					if atta[f] == null:
						for base_i in faces[f]:
							var v = this.curr_form().vertices[base_i] + Vector3(x,y,z)
							if not terr_v.has(v):
								terr_v[v] = terr_v.size()
						
							terr_i.append(terr_v[v])
					else:
						print("\t",f)
				
	$collider.shape.points = terr_v.keys()
	
	for v in terr_v:
		st.add_vertex(v)
	for j in terr_i:
		st.add_index(j)
		
	st.generate_normals()
	st.generate_tangents()
	st.commit($surface.mesh)

func _on_Timer_timeout():
	pass
	
