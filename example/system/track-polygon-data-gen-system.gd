extends System
class_name TrackPolygonDataGenSystem


var group = Ecs.TRACK_RENDER

func _process(_delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		gen_polygon_data(entity)


func gen_polygon_data(entity):
	if not entity.c_is_changed: return
	
	var from = entity.c_node_from
	var to = entity.c_node_to
	var leftPoint: Vector2 = from.c_pos
	var rightPoint = to.c_pos
	
	# Calculate the direction vector and its perpendicular
	var direction = (rightPoint - leftPoint).normalized()
	var perpendicular = Vector2(-direction.y, direction.x)
	
	# Define the thickness of the line
	var thickness = 2.0
	
	# Create a thin rectangle by offsetting points along the perpendicular
	entity.c_render_points = PackedVector2Array([
		leftPoint + perpendicular * thickness, # Top left
		leftPoint - perpendicular * thickness, # Bottom left
		rightPoint - perpendicular * thickness, # Bottom right
		rightPoint + perpendicular * thickness # Top right
	])
	
	
	#print("poligon points"+str(entity.c_render_points))
