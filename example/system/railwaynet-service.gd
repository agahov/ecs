extends System


class_name RailwayNetService


#var tracks: Array[Entity]
var tracks
var group = Ecs.TRACK


func get_next_node(node):
	tracks = get_tree().get_nodes_in_group(group)
	for track in tracks:
		if track.c_node_from == node:
			return track.c_node_to
	return null
