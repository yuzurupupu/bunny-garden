extends PlayerState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var like_duration: float = 3.0

@onready var like_timer: Timer = Timer.new()

func _ready() -> void:
	like_timer.one_shot = true
	like_timer.wait_time = like_duration
	like_timer.timeout.connect(_on_like_timeout)
	add_child(like_timer)

func _on_enter() -> void:
	animated_sprite_2d.play("like")
	like_timer.start()

func _on_exit() -> void:
	animated_sprite_2d.stop()
	like_timer.stop()

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

func _on_like_timeout() -> void:
	transition.emit("Idle")
