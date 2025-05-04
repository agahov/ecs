extends Component
class_name RailwayTrack


@export var node_from: Entity
@export var node_to: Entity

func get_comp_name() -> String:
	return Ecs.TRACK