class_name PlayerStateMachine
extends Node

@export var initial_state: PlayerState

var states: Dictionary = {}
var current_state: PlayerState
var current_state_name: String
var parent_name: String

func _ready() -> void:
	parent_name = get_parent().name
	
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
	
	if initial_state:
		enter_state(initial_state)

func _process(delta: float) -> void:
	if current_state:
		current_state._on_process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._on_physics_process(delta)
		current_state._on_next_transitions()

func transition_to(target_state_name: String) -> void:
	var normalized_name = target_state_name.to_lower()
	if normalized_name == current_state_name:
		return
	
	var new_state = states.get(normalized_name)
	if !new_state:
		return
	
	exit_current_state()
	enter_state(new_state)

func exit_current_state() -> void:
	if current_state:
		current_state._on_exit()

func enter_state(new_state: PlayerState) -> void:
	new_state._on_enter()
	current_state = new_state
	current_state_name = new_state.name.to_lower()
