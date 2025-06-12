extends NPC
@onready var interactable_component: InteractbaleComponent = $InteractableComponent
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	walk_cycles = randf_range(min_walk_cycle, max_walk_cycle)
	interactable_component.interactable_activated.connect(_on_player_nearby)
	interactable_component.interactable_deactivated.connect(_on_player_left)
	
func _on_player_nearby() -> void:
	if state_machine.current_node_state_name != "like":
		like_count += 1
		state_machine.transition_to("Like")


func _on_player_left() -> void:
	pass
