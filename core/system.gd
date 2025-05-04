extends Node
class_name System


var group_name: String = "renderable"
#position render size


func _ready() -> void:
	#pass
	deactivate()


func activate():
	set_process(true)
	print("activate system: " + name)
	_activate()
	
	
func deactivate():
	set_process(false)
	_deactivate()
	pass


func _activate() -> void:
	pass


func _deactivate() -> void:
	pass

func get_entities() -> Array:
	return get_tree().get_nodes_in_group(group_name)
