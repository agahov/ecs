extends System

#class_name RotationTrigerSystem

var group = Ecs.ROTATION_TRIGER

func _process(_delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		update_target(entity)


func update_target(entity):
	var rotation = entity.c_rot_angel
	var rotation_target = entity.c_target_angle
	
	var angle_diff = normalize_angle_deg(rotation_target - rotation)
	if abs(angle_diff) < 5.0:
	
	
	#if abs(abs(rotation) - abs(rotation_target)) < 5:
		print(".... ROTATION TRIGER | ROTATION  "+str(entity.c_rot_speed))
		print(".... ROTATION TRIGER | ROTATION_TARGET " + str(entity.c_target_angle))
		print(".... ROTATION TRIGER | DIRECTION " + str(entity.c_rot_angel))
		
		
		
		entity.c_rot_angel = rotation_target
		entity.remove_component(Ecs.ROTATION_TARGET)
		entity.remove_component(Ecs.ROT)
		
		
		
		
		#entity.print_groups("ROT TRIGER remove rotation ")
func normalize_angle_deg(angle: float) -> float:
	return fmod((angle + 180.0), 360.0) - 180.0
