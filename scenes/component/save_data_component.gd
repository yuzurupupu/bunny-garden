class_name SaveDataComponent
extends Node

@onready var parent_node: Node2D = get_parent() as Node2D

@export var  save_data_resoure: Resource

func _ready() -> void:
	add_to_group("save_data_component")

func _save_data() -> Resource:
	if parent_node == null:
		return null
		
	if save_data_resoure == null:
		push_error("save_data_resource: ", save_data_resoure, parent_node.name)
		return
		
	save_data_resoure._save_data(parent_node)
	
	return save_data_resoure
