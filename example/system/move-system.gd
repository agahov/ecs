extends System

class_name MoveSystem

var group = Ecs.MOVEABLE

func _process(delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		move(entity, delta)


func move(entity, delta):
	#var pos = entity.c_pos
	if not entity.is_in_group(Ecs.MOVEABLE):
		print("error: in movabale system not Movabel entity")
		return


	var speed = entity.c_speed
	var direction = entity.c_direction
	
	# Update position based on speed and direction
	entity.c_pos += direction * speed * delta
