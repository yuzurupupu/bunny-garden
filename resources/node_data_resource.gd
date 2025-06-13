class_name NodeDataResource
extends Resource

@export var global_position: Vector2 = Vector2.ZERO
@export var node_path: NodePath = NodePath("")
@export var parent_node_path: NodePath = NodePath("")

func _save_data(node: Node2D) -> void:
	if node == null:
		push_warning("Node is null. Cannot save data.")
		return

	global_position = node.global_position
	node_path = node.get_path()

	var parent_node = node.get_parent()
	if parent_node != null:
		parent_node_path = parent_node.get_path()
	else:
		parent_node_path = NodePath("")

func _load_data(window: Window) -> void:
	if not window.has_node(parent_node_path):
		push_warning("Parent node path not found in window: %s" % parent_node_path)
		return

	var parent_node = window.get_node(parent_node_path)
	if not window.has_node(node_path):
		push_warning("Target node path not found: %s" % node_path)
		return

	var node = window.get_node(node_path)
	if node is Node2D:
		node.global_position = global_position
	else:
		push_warning("Node is not a Node2D: %s" % node)
