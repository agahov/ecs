extends Node


@export var systems:Node

func _ready() -> void:
	#pass
	start()
	
	
func start() -> void:
	for child in systems.get_children():
		if child is System:
			# Activate the system
			child.activate()
