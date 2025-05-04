extends System
class_name PolygonDataGenSystem


var group = Ecs.POLYGON_DATA_GEN

func _process(_delta):
	# Get all entities in the moveable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		data_gen(entity)


func data_gen(entity):
	if not entity.c_is_changed: return
	#var polygon = entity.c_polygon
	
	if entity.c_shape == Ecs.Shapes.RECT:
		entity.c_render_points = rectPoints(entity)
	elif entity.c_shape == Ecs.Shapes.CIRCLE:
		entity.c_render_points = circlePoints(entity)
	elif entity.c_shape == Ecs.Shapes.TRIANGL:
		entity.c_render_points = trianglPoints(entity)

	
	#print("poligon points"+str(entity.c_render_points))
func rectPoints(entity) -> PackedVector2Array:
	var w = entity.c_width
	var h = entity.c_height
	
	var points = PackedVector2Array([
		Vector2(-w / 2, -h / 2), # Top left
		Vector2(w / 2, -h / 2), # Top right
		Vector2(w / 2, h / 2), # Bottom right
		Vector2(-w / 2, h / 2) # Bottom left
	])
	return points

func circlePoints(entity) -> PackedVector2Array:
	var radius = entity.c_width / 2 # Using x as diameter, so radius is half
	var points = PackedVector2Array()
	var segments = 32 # Number of segments to approximate the circle
	
	for i in range(segments):
		var angle = (i * 2 * PI) / segments
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		points.append(Vector2(x, y))
	
	return points
	
func trianglPoints(entity) -> PackedVector2Array:
	var width = entity.c_width
	var height = entity.c_height
	var points = PackedVector2Array()
	
	# Create an equilateral triangle pointing to the right
	points.append(Vector2(width / 2, 0)) # Point
	points.append(Vector2(-width / 2, height / 2)) # Bottom left
	points.append(Vector2(-width / 2, -height / 2)) # Top left
	
	return points
