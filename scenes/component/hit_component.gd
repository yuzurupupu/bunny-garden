# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

class_name HitComponent
extends Area2D

@export var current_tool : DataType.Tools = DataType.Tools.None
@export var hit_damage : int = 1
