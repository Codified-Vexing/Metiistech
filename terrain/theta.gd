tool
extends StaticBody

var verts = [Vector3(0,1,0), Vector3(1,1,0), Vector3(1,1,1), Vector3(0,1,1), Vector3(0,0,0), Vector3(1,0,0), Vector3(1,0,1), Vector3(0,0,1),]
var inds = [3,2,6,7,3,6,0,4,5,1,0,5,0,3,7,4,0,7,2,1,5,6,2,5,5,4,7,6,5,7,1,2,3,0,1,3]

func _ready():

	## GENERATE THE MESH
	$surface.mesh = Mesh.new()
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	
	$collider.shape.points = verts
	
	for each in verts:
		st.add_vertex(each)
		#st.add_uv(UVs[each])
	
	for each in inds:
		st.add_index(each)
	
	st.generate_normals()
	st.generate_tangents()
	st.commit($surface.mesh)
	

func _process(t):
	if Input.is_action_just_released("rebuild_chunks"):
		_ready()
