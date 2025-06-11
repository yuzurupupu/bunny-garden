class_name FieldCursorComponent
extends Node

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 3

@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if ToolManager.selected_tool != DataType.Tools.TillGround:
		return
	
	if event.is_action_pressed("remove_dirt"):
		process_cell_input(false)
	elif event.is_action_pressed("hit"):
		process_cell_input(true)
	

func process_cell_input(add: bool) -> void:
	if !is_instance_valid(grass_tilemap_layer) or !is_instance_valid(tilled_soil_tilemap_layer) or player == null:
		return

	get_cell_under_mouse()
	
	if distance > 20.0:
		return

	if add:
		add_tilled_soil_cell()
	else:
		remove_tilled_soil_cell()

func get_cell_under_mouse() -> void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_tilled_soil_cell() -> void:
	if tilled_soil_tilemap_layer.get_cell_source_id(cell_position) == -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)

func remove_tilled_soil_cell() -> void:
	if tilled_soil_tilemap_layer.get_cell_source_id(cell_position) != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], 0, -1, true)
