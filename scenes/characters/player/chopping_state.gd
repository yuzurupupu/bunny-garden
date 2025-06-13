extends PlayerState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

var direction_data := {
	Vector2.UP:    {"anim": "chopping_back",  "offset": Vector2(1, -20)},
	Vector2.DOWN:  {"anim": "chopping_front", "offset": Vector2(-1, 2)},
	Vector2.RIGHT: {"anim": "chopping_left",  "offset": Vector2(8, -2)},
	Vector2.LEFT:  {"anim": "chopping_right", "offset": Vector2(-8, -2)},
}

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2.ZERO

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	var direction := player.player_direction
	var data: Dictionary = direction_data.get(direction, direction_data[Vector2.DOWN])

	var anim: String = data["anim"]
	var offset: Vector2 = data["offset"]

	animated_sprite_2d.play(anim)
	hit_component_collision_shape.position = offset
	hit_component_collision_shape.disabled = false


func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
