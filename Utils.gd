const PI_HALF = deg2rad(90)
const PI = deg2rad(180)
const TWO_PI = deg2rad(360)

static func find_node_by_type(caller, type):
	if caller extends type:
		return caller
	else:
		for c in caller.get_children():
			var lN = find_node_by_type(c, type)
			if lN != null and lN extends type:
				return lN
	return null

static func find_nodes_by_type(caller, type, ignore_self = false):
	var l_array = []
	if not ignore_self and caller extends type:
		l_array.push_back(caller)
	for c in caller.get_children():
		_find_nodes_by_type(c, type, l_array)
	return l_array

static func _find_nodes_by_type(caller, type, array):
	if caller extends type:
		array.push_back(caller)
	for c in caller.get_children():
		_find_nodes_by_type(c, type, array)
	pass
	
static func find_node_from_ancesotr(caller, type):
	if caller extends type:
		return caller
	else:
		var l_parent = caller.get_parent()
		while(l_parent != null):
			if l_parent extends type:
				return l_parent
			else:
				l_parent = l_parent.get_parent()
		return null
	pass

static func set_global_rot(node2d, rad_angle):
	var l_mx = node2d.get_global_transform()
	var l_sin_r = sin(rad_angle)
	var l_cos_r = cos(rad_angle)
	l_mx[0] = Vector2(l_cos_r, -l_sin_r)
	l_mx[1] = Vector2(l_sin_r, l_cos_r) 
	node2d.set_global_transform(l_mx)
	pass
	
static func get_global_rot(node2d):
	var l_mx = node2d.get_global_transform()
	return l_mx.get_rotation()
	
static func set_parent_keep_matrix(child_node2d, parent_node2d):
	parent_node2d.add_child(child_node2d)
	child_node2d.set_pos(child_node2d.get_pos() - parent_node2d.get_pos())
	child_node2d.set_rot(child_node2d.get_rot() - parent_node2d.get_rot())
	
	var child_scale = child_node2d.get_scale()
	var parent_scale = parent_node2d.get_scale()
	
	child_node2d.set_scale(Vector2(child_scale.x / parent_scale.x, child_scale.y / parent_scale.y))
	pass
	
static func look_at_global(node2d, point2d):
	var l_g_r = node2d.get_global_pos().angle_to_point(point2d) + PI_HALF
	set_global_rot(node2d, l_g_r)

static func look_at_local(node2d, point2d):
	var l_l_r = node2d.get_pos().angle_to_point(point2d) + PI_HALF
	node2d.set_rot(l_l_r)
	pass
	
static func vector2_from_angle(rad_angle):
	return Vector2(sin(rad_angle), cos(rad_angle))
	
static func atan2_from_vector(vector2):
	return atan2(vector2.x, vector2.y)


