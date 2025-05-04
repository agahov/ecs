extends System

class_name RotationSystem

var group = Ecs.ROTATEABLE

func _process(delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		rotate(entity, delta)


func rotate(entity, delta):
	#entity.c_rot_speed * delta
	var new_rot = float(entity.c_rot_angel + float(entity.c_rot_speed * delta))
	
	entity.c_rot_angel = fmod(new_rot, 360.0)
	#print("ROTATION SYSTEM: " + str(entity.c_rot_angel))
