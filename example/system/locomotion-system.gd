extends System

class_name LocomotionSystem

#NEED TAGET GROUP
var group = Ecs.LOCOMOTION

const MIN_DISTANCE = 5
@export var railway_net_service: RailwayNetService


func _process(_delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)

	
	# Process each entity
	for entity in entities:
		set_target(entity)


#move separate to direction and speed

func set_target(entity):
	var start_entity: Entity = entity.c_prev_target as Entity
	var next_entity = railway_net_service.get_next_node(start_entity)
	
	if next_entity:
		entity.c_direction = entity.c_pos.direction_to(next_entity.c_pos)

		
		var target_comp = entity.add_component(Ecs.TARGET)
		target_comp.target = next_entity.c_pos
		print("LocomotionSys: next tartget:" + str(target_comp.target))
		target_comp.target_entity = next_entity
		
		#entity.print_groups("before remove need target " + entity.get_comps())

		entity.remove_component(Ecs.NEED_TARGET)
		#entity.print_groups("after remove " + entity.get_comps())
		
		
		#rotetion
		var rotation_speed = 50
		var direction = get_direction(entity.c_pos, target_comp.target, entity)
		
		var target_angle = get_target_angel(entity.c_pos, target_comp.target)

		#get_direction_angel(entity.c_pos, target_comp.target)
		
		var rotation_comp = entity.add_component(Ecs.ROT)
		rotation_comp.rot_speed = rotation_speed * direction
		
		var rotation_target_comp = entity.add_component(Ecs.ROTATION_TARGET)
		rotation_target_comp.target_angle = target_angle
		
		print(".... LOCOMOTION | ROTATION  "+str(rotation_comp.rot_speed))
		print(".... LOCOMOTION | ROTATION_TARGET " + str(target_angle))
		print(".... LOCOMOTION | DIRECTION " + str(entity.c_rot_angel))
		
	else:
		print("the next_node is not found for start_node:" + str(start_entity.c_pos))



	
func normalize_angle_deg(angle: float) -> float:
	return fmod((angle + 180.0), 360.0) - 180.0

func get_direction(pos: Vector2, target: Vector2, entity: Entity):
	var direction_vector = target - pos
	var target_angle = normalize_angle_deg(rad_to_deg(direction_vector.angle()))
	var current_angle = normalize_angle_deg(entity.c_rot_angel)
	var angle_diff = normalize_angle_deg(target_angle - current_angle)
	var direction = sign(angle_diff)
	
	print("Current: ", current_angle, " Target: ", target_angle, " Diff: ", angle_diff, " Dir: ", direction)
	return direction


func get_target_angel(pos: Vector2, target: Vector2):
	var direction_vector = target - pos
	return rad_to_deg(direction_vector.angle())
