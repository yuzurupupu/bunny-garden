extends Node

var selected_tool: DataType.Tools = DataType.Tools.None

signal tool_selected(tool: DataType.Tools)
signal enable_tool(tool : DataType.Tools)

func select_tool(tool: DataType.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool

func enable_tool_button(tool : DataType.Tools) -> void:
	enable_tool.emit(tool)
