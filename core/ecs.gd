extends Node

const RENDERABL = "renderable"
const GLOBAL_RENDERABL = "global_renderable"
const MOVEABLE = "moveable"
const ROTATEABLE = "rotateable"

const LOCOMOTION = "locomotion"

const POSITION = "positon"
const SIZE = "size"
const STYLE = "style"
const MOVE = "move"
const TARGET = "target"
const TRACK = "track"
const TRACK_RENDER = "track_render"
const GLOBAL_RENDER = "global_render"

const GEOMETRY_SHAPE = "geometry_shape"
const POLYGON_RENDER = "polygon_render"
const POLYGON_DATA_GEN = "geometry_data_gen"

# Rotation related constants
const DIRECTION = "direction"
const ROT = "rot"
const ROTATION_TARGET = "rotation_target"
const ROTATION_TRIGER = "rotation_triger"

#const RENDER_FORM = "render_data"

## extend  render to asstet, and geo, 
#const RENDER = "render"
const NEED_TARGET = "need_target"

# Dictionary to store component type mappings
var _component_types = {}

var group_components = {
	ROTATEABLE: [ROT, DIRECTION],
	ROTATION_TRIGER: [DIRECTION, ROTATION_TARGET],

	RENDERABL: [POSITION, STYLE, POLYGON_RENDER, DIRECTION],
	GLOBAL_RENDERABL: [STYLE, POLYGON_RENDER, GLOBAL_RENDER],
	MOVEABLE: [POSITION, MOVE, TARGET],
	LOCOMOTION: [POSITION, NEED_TARGET],
	TRACK: [TRACK],
	TRACK_RENDER: [TRACK, POLYGON_RENDER],
	POLYGON_DATA_GEN: [GEOMETRY_SHAPE, POLYGON_RENDER]
	
}


enum Shapes {CIRCLE, RECT, TRIANGL ,POLIGON}


# Register a component type
func register_component_type(component_name: String, component_script: Script) -> void:
	_component_types[component_name] = component_script

# Create a new component instance
func create_component(component_name: String) -> Component:
	var component_script = _component_types.get(component_name)
	if component_script:
		var component = component_script.new()
		return component
	push_warning("Component type '%s' not found in factory" % component_name)
	return null

# Get all registered component types
func get_registered_components() -> Array:
	return _component_types.keys()

# Initialize component types
func _ready():
	# Register all component types
	register_component_type(POSITION, preload("res://example/comp/position.gd"))
	register_component_type(SIZE, preload("res://example/comp/size.gd"))
	register_component_type(STYLE, preload("res://example/comp/style.gd"))
	register_component_type(MOVE, preload("res://example/comp/move.gd"))
	register_component_type(TARGET, preload("res://example/comp/target.gd"))
	register_component_type(POLYGON_RENDER, preload("res://example/comp/polygon-render.gd"))
	register_component_type(NEED_TARGET, preload("res://example/comp/needTarget.gd"))
	register_component_type(TRACK, preload("res://example/comp/railwaytrack.gd"))
	
	# Register new rotation components
	register_component_type(DIRECTION, preload("res://example/comp/direction.gd"))
	register_component_type(ROT, preload("res://example/comp/rotation.gd"))
	register_component_type(ROTATION_TARGET, preload("res://example/comp/rotation_target.gd"))
