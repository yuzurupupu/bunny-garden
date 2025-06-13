extends PlayerState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

var direction: Vector2

var walk_animations := {
	Vector2.UP: "walk_back",
	Vector2.DOWN: "walk_front",
	Vector2.RIGHT: "walk_left",
	Vector2.LEFT: "walk_right",
}

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	direction = GameInputEvent.movement_input()
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
		var anim_name = walk_animations.get(direction, "walk_front")
		if animated_sprite_2d.animation != anim_name or not animated_sprite_2d.is_playing():
			animated_sprite_2d.play(anim_name)
	else:
		animated_sprite_2d.stop()
	
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvent.is_movement_input():
		transition.emit("Idle")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animated_sprite_2d.stop()
