extends System


class_name TargetTriger
"""
 Check If item reached target 
"""

var group = Ecs.MOVEABLE


const MIN_DISTANCE = 10

func _process(_delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		check_disance(entity)


func check_disance(entity):
	var pos = entity.c_pos
	var target = entity.c_target
	if pos.distance_to(target) < MIN_DISTANCE:
		var need_target_comp = entity.add_component(Ecs.NEED_TARGET)
		need_target_comp.prev_target = entity.c_target_entity
		#entity.c_prev_target = entity.c_target_entity.duplicate()
		entity.remove_component(Ecs.TARGET)
		#remove target
	# Update position based on speed and direction
