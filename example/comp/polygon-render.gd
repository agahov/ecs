extends Component

class_name PolygonRender


#var rot_angel:int = 0 

var render_points: PackedVector2Array # points
var polygon: Polygon2D = Polygon2D.new()
var is_changed: bool = true

func get_comp_name() -> String:
	return Ecs.POLYGON_RENDER


func _ready() -> void:
	pass
	#add_child(polygon)
