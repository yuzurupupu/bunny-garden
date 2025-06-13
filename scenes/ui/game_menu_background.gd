# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

extends Node2D


func _ready()-> void:
	call_deferred("set_scene_process_mode")

func set_scene_process_mode()-> void:
	process_mode =PROCESS_MODE_DISABLED
