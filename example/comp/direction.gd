extends Component

@export var rot_angel: float = 0.0:
	set(value):
		rot_angel = value

	 
func get_comp_name() -> String:
	return Ecs.DIRECTION
