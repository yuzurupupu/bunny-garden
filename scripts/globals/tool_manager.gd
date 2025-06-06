extends Node

var selected_tool: DataType.Tools = DataType.Tools.None

signal tool_selected(tool: DataType.Tools)

func select_tool(tool: DataType.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool
