# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

class_name TileMapLayerDataResource
extends NodeDataResource

@export var tilemap_layer_used_cells: Array[Vector2i]
@export var terrain_set: int = 0
@export var terrain: int = 3

func _save_data(node: Node2D) -> void:
	super._save_data(node)
	
	var tilemap_layer: TileMapLayer = node as TileMapLayer
	var cells: Array[Vector2i] = tilemap_layer.get_used_cells()
	
	tilemap_layer_used_cells = cells

func _load_data(window: Window) -> void:
	var scen_node = window.get_node_or_null(node_path)
	
	if scen_node != null:
		var tilemap_layer: TileMapLayer = scen_node as TileMapLayer
		tilemap_layer.set_cells_terrain_connect(tilemap_layer_used_cells, terrain_set, true)
