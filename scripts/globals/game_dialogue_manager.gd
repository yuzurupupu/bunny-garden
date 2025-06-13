# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

extends Node

signal give_crop_seeds
signal feed_the_animals


func action_give_crop_seeds() -> void:
	give_crop_seeds.emit()

func action_feed_animals() -> void:
	feed_the_animals.emit()
