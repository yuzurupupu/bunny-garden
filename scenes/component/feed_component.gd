# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

class_name FeedComponent
extends Area2D

signal food_received(area: Area2D)


func _on_area_entered(area: Area2D) -> void:
	food_received.emit(area)
