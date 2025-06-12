class_name CropsCursorComponent
extends Node

@export var tilled_soil_tilemap_layer: TileMapLayer
var player: Player

var crop_scenes := {
	DataType.Tools.PlantCorn: preload("res://scenes/objects/plants/corn.tscn"),
	DataType.Tools.PlantTomato: preload("res://scenes/objects/plants/tomato.tscn"),
	DataType.Tools.PlantWheat: preload("res://scenes/objects/plants/wheat.tscn"),
	DataType.Tools.PlantCarrot: preload("res://scenes/objects/plants/carrot.tscn"),
}

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float
const PLANT_RANGE: float = 20.0
const POSITION_TOLERANCE: float = 1.0

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if ToolManager.selected_tool == DataType.Tools.TillGround and event.is_action_pressed("remove_dirt"):
		process_cell(true)
	elif ToolManager.selected_tool in crop_scenes.keys() and event.is_action_pressed("hit"):
		process_cell(false)

func process_cell(remove: bool) -> void:
	if !is_instance_valid(tilled_soil_tilemap_layer) or player == null:
		return

	get_cell_under_mouse()
	if distance > PLANT_RANGE:
		return

	if remove:
		remove_crop()
	else:
		add_crop()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_crop() -> void:
	var crop_fields = get_parent().find_child("CropFields")
	if crop_fields == null or has_crop_at_position(crop_fields, local_cell_position):
		return

	var crop_scene = crop_scenes.get(ToolManager.selected_tool, null)
	if crop_scene == null:
		return

	var crop_instance = crop_scene.instantiate()
	crop_instance.global_position = local_cell_position
	crop_fields.add_child(crop_instance)

func remove_crop() -> void:
	var crop_fields = get_parent().find_child("CropFields")
	if crop_fields == null:
		return

	for node in crop_fields.get_children():
		if node is Node2D and node.global_position.distance_to(local_cell_position) < POSITION_TOLERANCE:
			node.queue_free()
			return

func has_crop_at_position(container: Node, position: Vector2) -> bool:
	for node in container.get_children():
		if node is Node2D and node.global_position.distance_to(position) < POSITION_TOLERANCE:
			return true
	return false
