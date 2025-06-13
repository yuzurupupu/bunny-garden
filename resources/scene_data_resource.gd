class_name SceneDataResource
extends NodeDataResource

@export var node_name: String = ""
@export var scene_file_path: String = ""

func _save_data(node: Node2D) -> void:
	if node == null:
		push_warning("Node is null. Cannot save data.")
		return

	super._save_data(node)

	node_name = node.name
	scene_file_path = node.scene_file_path

func _load_data(window: Window) -> void:
	if parent_node_path.is_empty() or scene_file_path == "":
		push_warning("Scene file path or parent node path is empty.")
		return

	var parent_node := window.get_node_or_null(parent_node_path)
	if parent_node == null:
		push_warning("Parent node not found: %s" % parent_node_path)
		return

	var scene_resource := load(scene_file_path)
	if scene_resource == null or not scene_resource is PackedScene:
		push_warning("Failed to load scene from: %s" % scene_file_path)
		return

	var scene_node: Node2D = scene_resource.instantiate() as Node2D
	if scene_node == null:
		push_warning("Failed to instantiate scene or cast to Node2D.")
		return

	scene_node.name = node_name
	scene_node.global_position = global_position
	parent_node.add_child(scene_node)
