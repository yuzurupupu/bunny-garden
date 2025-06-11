extends PanelContainer
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn_seed: Button = $MarginContainer/HBoxContainer/ToolCornSeed
@onready var tool_tomato_seed: Button = $MarginContainer/HBoxContainer/ToolTomatoSeed
@onready var tool_carrot_seed: Button = $MarginContainer/HBoxContainer/ToolCarrotSeed

func _ready()-> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	
	tool_tilling.disabled = true
	tool_tilling.focus_mode = Control.FOCUS_NONE
	
	tool_watering_can.disabled = true
	tool_watering_can.focus_mode = Control.FOCUS_NONE
	
	tool_corn_seed.disabled = true
	tool_corn_seed.focus_mode = Control.FOCUS_NONE
	
	tool_tomato_seed.disabled = true
	tool_tomato_seed.focus_mode = Control.FOCUS_NONE
	
	tool_carrot_seed.disabled = true
	tool_carrot_seed.focus_mode = Control.FOCUS_NONE

func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.AxeWood)


func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.TillGround)


func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.WaterCrops)


func _on_tool_corn_seed_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.PlantCorn)


func _on_tool_tomato_seed_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.PlantTomato)


func _on_tool_carrot_seed_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.PlantCarrot)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataType.Tools.None)
		tool_axe.release_focus()
		tool_carrot_seed.release_focus()
		tool_corn_seed.release_focus()
		tool_tilling.release_focus()
		tool_tomato_seed.release_focus()
		tool_watering_can.release_focus()
		
func on_enable_tool_button(tool: DataType.Tools) -> void:
	if tool == DataType.Tools.TillGround:
		tool_tilling.disabled = false
		tool_tilling.focus_mode = Control.FOCUS_ALL
	
	elif tool == DataType.Tools.WaterCrops:
		tool_watering_can.disabled = false
		tool_watering_can.focus_mode = Control.FOCUS_ALL
		
	elif tool == DataType.Tools.PlantCorn:
		tool_corn_seed.disabled = false
		tool_corn_seed.focus_mode = Control.FOCUS_ALL
		
	elif tool == DataType.Tools.PlantTomato:
		tool_tomato_seed.disabled = false
		tool_tomato_seed.focus_mode = Control.FOCUS_ALL
		
	elif tool == DataType.Tools.PlantCarrot:
		tool_carrot_seed.disabled = false
		tool_carrot_seed.focus_mode = Control.FOCUS_ALL
