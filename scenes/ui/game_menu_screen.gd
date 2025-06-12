extends CanvasLayer

@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton

func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE

func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()


func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game()


func _on_start_level_1_button_pressed() -> void:
	GameManager.start_level1()
	queue_free()


func _on_start_level_2_button_pressed() -> void:
	GameManager.start_level2()
	queue_free()


func _on_start_level_3_button_pressed() -> void:
	GameManager.start_level3()
	queue_free()


func _on_start_level_4_button_pressed() -> void:
	GameManager.start_level4()
	queue_free()
