extends Component

class_name Render


var polygon: Polygon2D = Polygon2D.new()

func get_comp_name() -> String:
	return Ecs.RENDER


func _ready() -> void:
	add_child(polygon)