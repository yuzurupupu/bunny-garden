class_name NPC
extends CharacterBody2D

@export var min_walk_cycle: int = 2
@export var max_walk_cycle: int = 6
var like_count: int = 0

var walk_cycles: int
var current_walk_cycle: int
