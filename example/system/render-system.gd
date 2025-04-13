extends System

class_name RenderSystem

var group = Ecs.RENDERABL


func _ready() -> void:
	print("render")


func _process(_delta):
	# Get all entities in the renderable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		render(entity)


func render(entity):
	var pos = entity.c_pos # from Position component
	#var size = entity.size # from Size component
	var size = 100 # from Size component
	var bg_color = entity.c_bg_color # from Size component
	var polygon = entity.c_polygon

	var points = PackedVector2Array([
		Vector2(-size / 2, -size / 2), # Top left
		Vector2(size / 2, -size / 2), # Top right
		Vector2(size / 2, size / 2), # Bottom right
		Vector2(-size / 2, size / 2) # Bottom left
	])
	polygon.position = pos
	polygon.polygon = points
	polygon.color = bg_color
