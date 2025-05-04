extends Node
class_name Entity

# Entity should not have its own properties.
# All properties should come from components.
# Example: entity.pos (from Position component) instead of entity.position.pos

# Dictionary to map group names to arrays of required component types
var _group_components = Ecs.group_components

func _ready():
	# Connect to child signals
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exiting_tree)
	for g in _group_components:
		_update_group_membership(g)
	
	
	


# Check if entity has all components required for a group
func _has_all_components_for_group(group_name: String) -> bool:
	var required_components = _group_components.get(group_name, [])
	#print("req comp: ", required_components)
	for comp_type in required_components:
		var has_component = false
		for child in get_children():
			#print(child.get_comp_name())
			if child.get_comp_name() == comp_type:
				has_component = true
				break
		if not has_component:
			return false
	return true

# Update group membership based on current components
func _update_group_membership(group_name: String):
	if _has_all_components_for_group(group_name):
		if not is_in_group(group_name):
			#print("+ add to group: "+group_name +" "+self.name+" comp:"+ get_comps() )
			add_to_group(group_name)
	else:
		if is_in_group(group_name):
			print("- remove from group: "+group_name +" "+  self.name+" comp:"+ get_comps() )
			remove_from_group(group_name)

func _on_child_entered_tree(node: Node):
	if node is Component:
		# Update all groups that might be affected
		for group_name in _group_components.keys():
			_update_group_membership(group_name)

func _on_child_exiting_tree(node: Node):
	if node is Component:
		# Update all groups that might be affected
		for group_name in _group_components.keys():
			_update_group_membership(group_name)

func _get(property):
	# If property starts with c_, look for it in components without the prefix
	if property.begins_with("c_"):
		var comp_property = property.substr(2) # Remove c_ prefix
		# Search through all components for the property
		for child in get_children():
			if child.get(comp_property) != null:
				return child[comp_property]
		
		# If property not found in any component, print warning
		push_warning("Component property '%s' not found in any component" % comp_property)
		#print_groups("entity groups: ")
		return null
	
	# For non-prefixed properties, return null
	return null

func _set(property, value):
	# If property starts with c_, look for it in components without the prefix
	if property.begins_with("c_"):
		var comp_property = property.substr(2) # Remove c_ prefix
		# Try to find a component with the property name
		var comp = findCompByProperty(comp_property)
		if comp:
			# If the component exists, try to set the property
			if comp.get(comp_property) != null:
				comp[comp_property] = value
				return true
		return false
	
	# For non-prefixed properties, return false
	return false



func findCompByName(comp_name):
	for child in get_children():
		if child.get_comp_name() == comp_name:
			return child
	return null		
	

func findCompByProperty(property):
	# Search through all components for the property
	for child in get_children():
		if child.get(property) != null:
			return child
	
	# If property not found in any component, print warning
	push_warning("Property '%s' not found in any component" % property)
	
	return null

# Add a new component to the entity
func add_component(component_name: String) -> Component:
	var component = Ecs.create_component(component_name)
	if component:
		add_child(component)
		# Update all groups that might be affected
		for group_name in _group_components.keys():
			_update_group_membership(group_name)
	return component

func remove_component(component_name: String) -> void:
	var component = findCompByName(component_name)
	if component:
		remove_child(component)
		component.queue_free()
		# Update all groups that might be affectedx
		for group_name in _group_components.keys():
			_update_group_membership(group_name)
	


func get_comps():
	var comps = ""
	for child in get_children():
		comps += child.get_comp_name() + " |"
	return comps


func print_groups(msg = ""):
	print("Entity groups: " + msg)
	for group in get_groups():
		print("- ", group)
