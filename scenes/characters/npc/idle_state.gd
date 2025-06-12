
extends PlayerState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var idle_state_time_interval: float = 10.0

@onready var idle_state_timer: Timer = Timer.new()

var idle_state_timeout: bool = false

func _ready() -> void:
	idle_state_timer.wait_time = idle_state_time_interval
	idle_state_timer.timeout.connect(on_idle_state_timeout)
	add_child(idle_state_timer)
	
func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	if idle_state_timeout:
		var choices := {
			"Walk": 40,
			"Observe": 30,
			"Sleep": 20,
			"Jump": 10
		}
		
		var state_pool: Array[String] = []
		for state in choices.keys():
			for i in choices[state]:
				state_pool.append(state)

		if state_pool.size() > 0:
			var next_state = state_pool[randi() % state_pool.size()]
			transition.emit(next_state)

func _on_enter() -> void:
	animated_sprite_2d.play("idle")
	idle_state_timeout = false
	idle_state_timer.start()


func _on_exit() -> void:
	animated_sprite_2d.stop()
	idle_state_timer.stop()
	
func on_idle_state_timeout() -> void:
	idle_state_timeout = true
