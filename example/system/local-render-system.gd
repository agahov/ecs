@tool
extends System

class_name RenderSystem

var group = Ecs.RENDERABL

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
	var pos = entity.c_pos
	var polygon = entity.c_polygon
	polygon.position = pos

	var rotation_angle = entity.c_rot_angel
	#if rotation_angle!=0:
		#print("rotation_angle: "+str(rotation_angle))
		#print("rotation_angle: "+str(entity.c_rot_angel))
	
	
	polygon.rotation_degrees = rotation_angle
	
	#if not entity.c_is_changed:
		#return

	var bg_color = entity.c_bg_color # from Size component

	polygon.polygon = entity.c_render_points
	polygon.color = bg_color
	
	entity.c_is_changed = false
