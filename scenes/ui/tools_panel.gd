extends PanelContainer
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn_seed: Button = $MarginContainer/HBoxContainer/ToolCornSeed
@onready var tool_tomato_seed: Button = $MarginContainer/HBoxContainer/ToolTomatoSeed
@onready var tool_carrot_seed: Button = $MarginContainer/HBoxContainer/ToolCarrotSeed

			
func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.AxeWood)


func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.TillGround)


func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.WaterCrops)


func _on_tool_corn_seed_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.PlantCorn)


func _on_tool_tomato_seed_pressed() -> void:
	ToolManager.select_tool(DataType.Tools.PlantTomated)


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
