extends Node2D
var ballon_scene = preload("res://dialogue/game_dialogue_ballon.tscn")

@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var interactable_component: InteractbaleComponent = $InteractableComponent
	
var in_range: bool

func _ready()-> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	GameDialogueManager.give_crop_seeds.connect(on_give_crop_seeds)
	
func on_interactable_activated()-> void:
	interactable_label_component.show()
	in_range =true
	
func on_interactable_deactivated()-> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("show_dialogue"):
			var ballon: BaseGameDialogueBallon = ballon_scene.instantiate()
			get_tree().current_scene.add_child(ballon)
			ballon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
	
func on_give_crop_seeds() -> void:
	ToolManager.enable_tool_button(DataType.Tools.TillGround)
	ToolManager.enable_tool_button(DataType.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataType.Tools.PlantCorn)
	ToolManager.enable_tool_button(DataType.Tools.PlantTomato)
	ToolManager.enable_tool_button(DataType.Tools.PlantCarrot)
	
