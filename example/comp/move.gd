extends Component
class_name MoveComponent


@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.ZERO

func get_comp_name() -> String:
	return Ecs.MOVE
