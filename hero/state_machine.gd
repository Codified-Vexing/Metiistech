var me
var name: String

signal restate(which)

func loaded():
	# When this state is sucessfully read from the file and loaded to the machine.
	pass

func _ready():
	# to inherit type the following on the children classes:
	# ._ready()
	name = get_script().get_path().get_file().trim_suffix(".gd")
	
func entry():
	print(name+"ing")

func exit():
	pass

func proceed(dt):
	pass

func react(ev):
	pass
