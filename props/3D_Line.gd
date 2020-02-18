tool
class_name Ribbon3D, "res://icons/ribbon3d.png"

extends ImmediateGeometry

export(float) var girth := 2
export(float) var thickness := 3
export(float) var slack := 1
export(int) var segments := 0
export(Vector3) var start := Vector3(0,0,0)
export(Vector3) var end := Vector3(0,0,20)

func _ready():
	
	begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	for each in range(segments+1):
		segment(start, end)
	end()

func segment(from, to):
	add_vertex(from)
	add_vertex(to)
	add_vertex(to + Vector3(thickness, 0, 0))
	add_vertex(from + Vector3(thickness,0,0))
	add_vertex(from + Vector3(thickness,girth,0))
	add_vertex(to + Vector3(thickness, girth, 0))
	add_vertex(to)
	add_vertex(from)
	
