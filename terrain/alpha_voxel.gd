tool
extends StaticBody

var rng = RandomNumberGenerator.new()
var i_seed : int = 0xdeadbeef

var buried = {}
var verts = [] #[Vector3(0,1,0), Vector3(1,1,0), Vector3(1,1,1), Vector3(0,1,1), Vector3(0,0,0), Vector3(1,0,0), Vector3(1,0,1), Vector3(0,0,1),]
var inds = [] #[0,1,2,0,2,3,0,3,7,0,7,4,0,4,5,0,5,1,6,1,5,6,2,1,6,3,2,6,7,3,6,4,7,6,5,4]
var matter := {}
var mapping := []


func print_map():
	var out = ""
	for x in mapping:
		for y in x:
			for z in y:
				out += "[" + z.name + "] "
			
			print(out)

func _ready():
	mapping = []

	## GENERATE BLOCKS
	var block
	var path = "res://entities/"
	var folder = Directory.new()
	folder.open(path)
	folder.list_dir_begin(true, true)
	var file = folder.get_next()
	
	while file != "":
		if file != "scenes":
			var url = path + file
			matter[file.trim_suffix(".gd")] = load(url)

		file = folder.get_next()
	folder.list_dir_end()

	for x in range(8):
		mapping.append([])
		for y in range(3):
			mapping[x].append([])
			for z in range(8):
				var the_air = matter["air"].new()
				mapping[x][y].append(the_air)
				for id in matter:
					var b = matter[id].new()
					b.land = self
					b._ready()
					b = b.spawn(Vector3(x,y,z))
					if b:
						put_at(b, Vector3(x,y,z))
						for v in b.verts:
							v = v*Vector3(x+1,y+1,z+1)
							match buried.get(v, false):
								0, false:
									buried[v]=1
									verts.append(v)
								1, 2:
									buried[v]+=1
								3, 4:
									if verts.has(v):
										verts.erase(v)

	## GENERATE THE MESH
	var tmpmsh = Mesh.new()
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	
	$collider.shape.points = verts
	
	for each in verts:
		st.add_vertex(each)
		#st.add_uv(UVs[each])
	
	#for each in inds:
	#	st.add_index(each)
	
	st.generate_normals()
	st.generate_tangents()
	st.commit(tmpmsh)
	
	$surface.mesh = tmpmsh
	

func _process(t):
	if Input.is_action_just_released("rebuild_chunks"):
		_ready()


func sprout(who, where):
	# Place entities in the world that aren't part of the terrain mesh.
	add_child(who)
	who.translation = where
	
func put_at(who, coord):
	# try placing a block unless already occupied.
	if not mapping[coord.x][coord.y][coord.z].is_solid:
		mapping[coord.x][coord.y][coord.z] = who

func replace(who, coord):
	# remove existing block to place the new one
	
	pass

func drop(who, x, y):
	# place on top of the first block that isn't empty
	pass
