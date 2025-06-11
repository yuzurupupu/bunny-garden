extends Node

func _ready() -> void:
	call_deferred("enable_tool_button")
	
func enable_tool_button() -> void:
	ToolManager.enable_tool_button(DataType.Tools.TillGround)
	ToolManager.enable_tool_button(DataType.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataType.Tools.PlantCorn)
	ToolManager.enable_tool_button(DataType.Tools.PlantTomato)
	ToolManager.enable_tool_button(DataType.Tools.PlantCarrot)
