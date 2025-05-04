@tool
extends System

class_name GlobalRenderSystem

var group = Ecs.GLOBAL_RENDERABL

@export var canvas: Node2D

func _ready() -> void:
	pass
	#print("render")


func _activate() -> void:
	
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		canvas.add_child(entity.c_polygon)
		
		
func _process(_delta):
	# Get all entities in the renderable group
	var entities = get_tree().get_nodes_in_group(group)
	
	# Process each entity
	for entity in entities:
		render(entity)


#render data point
func render(entity):
	#??? position 
	
	var polygon = entity.c_polygon
	polygon.position = Vector2.ZERO
	#var size = entity.size # from Size component
	if not entity.c_is_changed:
		return

	var bg_color = entity.c_bg_color # from Size component
	polygon.polygon = entity.c_render_points
	polygon.color = bg_color
	entity.c_is_changed = false
	
	

	
	
