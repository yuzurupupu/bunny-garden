# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

class_name InteractbaleComponent
extends Area2D

signal interactable_activated
signal interactable_deactivated


func _on_body_entered(body: Node2D) -> void:
	interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	interactable_deactivated.emit()
