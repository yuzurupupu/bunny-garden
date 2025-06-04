extends PlayerState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var observe_duration: float = 2.5

@onready var observe_timer: Timer = Timer.new()

var is_done_observing: bool = false

func _ready() -> void:
	observe_timer.wait_time = observe_duration
	observe_timer.timeout.connect(on_observe_done)
	add_child(observe_timer)

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_enter() -> void:
	is_done_observing = false
	animated_sprite_2d.play("observe")
	observe_timer.start()

func _on_exit() -> void:
	observe_timer.stop()
	animated_sprite_2d.stop()

func _on_next_transitions() -> void:
	if is_done_observing:
		transition.emit("Idle")

func on_observe_done() -> void:
	is_done_observing = true
