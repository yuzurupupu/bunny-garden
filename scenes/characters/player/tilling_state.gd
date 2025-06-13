extends PlayerState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

var direction_animations := {
	Vector2.UP: "tilling_back",
	Vector2.DOWN: "tilling_front",
	Vector2.RIGHT: "tilling_left",
	Vector2.LEFT: "tilling_right",
}

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	var anim_name = direction_animations.get(player.player_direction, "tilling_front")
	animated_sprite_2d.play(anim_name)

func _on_exit() -> void:
	animated_sprite_2d.stop()
