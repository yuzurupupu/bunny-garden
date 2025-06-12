extends Node
var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")

func _unhandled_input(event: InputEvent)-> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func start_level1() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level1")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true
	
func start_level2() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level2")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true
	
func start_level3() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level3")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true
	
func start_level4() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level4")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true
	
func exit_game() -> void:
	get_tree().quit()

func show_game_menu_screen()-> void:
	var game_menu_screen_instance = game_menu_screen.instantiate()
	get_tree().root.add_child(game_menu_screen_instance)
