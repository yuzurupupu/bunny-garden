extends Node2D

var balloon_scene: PackedScene = preload("res://dialogue/game_dialogue_ballon.tscn")
var dialogue_resource: Resource = preload("res://dialogue/conversations/animal_guide.dialogue")

@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var interactable_component: InteractbaleComponent = $InteractableComponent

var in_range: bool = false

func _ready() -> void:
	interactable_component.interactable_activated.connect(_on_interactable_activated)
	interactable_component.interactable_deactivated.connect(_on_interactable_deactivated)
	
	interactable_label_component.hide()

func _on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func _on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("show_dialogue"):
		var balloon: BaseGameDialogueBallon = balloon_scene.instantiate()
		get_tree().root.add_child(balloon)
		balloon.start(dialogue_resource, "start")
