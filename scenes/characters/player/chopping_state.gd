extends PlayerState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("chopping_back")
		hit_component_collision_shape.position = Vector2(1, -20)
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("chopping_front")
		hit_component_collision_shape.position = Vector2(-1, 2)
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("chopping_left")
		hit_component_collision_shape.position = Vector2(8, -2)
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("chopping_right")
		hit_component_collision_shape.position = Vector2(-8, -2)
	else:
		animated_sprite_2d.play("chopping_front")
		hit_component_collision_shape.position = Vector2(-1, 2)
		
	hit_component_collision_shape.disabled = false
	


func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
