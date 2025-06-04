extends PlayerState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var sleep_duration: float = 10.0

@onready var sleep_timer: Timer = Timer.new()

var is_awake: bool = false

func _ready() -> void:
	sleep_timer.wait_time = sleep_duration
	sleep_timer.timeout.connect(on_wake_up)
	add_child(sleep_timer)

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_enter() -> void:
	is_awake = false
	animated_sprite_2d.play("sleep")
	sleep_timer.start()

func _on_exit() -> void:
	sleep_timer.stop()
	animated_sprite_2d.stop()

func _on_next_transitions() -> void:
	if is_awake:
		transition.emit("Idle")

func on_wake_up() -> void:
	is_awake = true
