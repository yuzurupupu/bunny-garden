extends PlayerState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var jump_force: float = -200.0
@export var gravity: float = 500.0
@export var jump_duration: float = 0.5

var jump_timer: float = 0.0
var is_jumping: bool = false
var velocity: Vector2 = Vector2.ZERO

func _on_enter() -> void:
	velocity = Vector2(0, jump_force)
	jump_timer = 0.0
	is_jumping = true
	animated_sprite_2d.play("jump")

func _on_exit() -> void:
	animated_sprite_2d.stop()
	is_jumping = false

func _on_process(delta: float) -> void:
	if is_jumping:
		jump_timer += delta
		velocity.y += gravity * delta
		character.move_and_slide()

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transitions() -> void:
	if jump_timer >= jump_duration:
		transition.emit("Idle")
