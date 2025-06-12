extends Node2D

var ballon_scene = preload("res://dialogue/game_dialogue_ballon.tscn")

var corn_harvest_scene = preload("res://scenes/objects/plants/corn_havest.tscn")
var tomato_harvest_scene = preload("res://scenes/objects/plants/tomato_harvest.tscn")
var carrot_harvest_scene = preload("res://scenes/objects/plants/carrot_harvest.tscn")
var wheat_harvest_scene = preload("res://scenes/objects/plants/wheat_harvest.tscn")

@onready var interactable_component: InteractbaleComponent = $InteractableComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var feed_component: FeedComponent = $FeedComponent
@onready var reward_marker: Marker2D = $RewardMarker
@onready var interactable_label_component: Control = $InteractableLabelComponent

@export var animals: Node2D
@export var dialogue_start_command: String
@export var food_drop_height:int = 40
@export var reward_output_radius: int = 20
@export var output_reward_scenes: Array[PackedScene] =[]
@export var advanced_egg_scene: PackedScene
@export var advanced_milk_scene: PackedScene

var in_range: bool
var is_chest_open: bool

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	feed_component.food_received.connect(on_food_received)
	
func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated()-> void:
	if is_chest_open:
		animated_sprite_2d.play("chest_close")
		
	is_chest_open = false
	interactable_label_component.hide()
	in_range = false
	
func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("show_dialogue"):
			interactable_label_component.hide()
			animated_sprite_2d.play("chest_open")
			is_chest_open = true
			
			var ballon: BaseGameDialogueBallon = ballon_scene.instantiate()
			get_tree().root.add_child(ballon)
			ballon.start(load("res://dialogue/conversations/chest.dialogue"), dialogue_start_command)
			
func on_feed_the_animals() -> void:
	if in_range:
		trigger_feed_harvest("corn", corn_harvest_scene)
		trigger_feed_harvest("tomato", tomato_harvest_scene)
		trigger_feed_harvest("carrot", carrot_harvest_scene)
		trigger_feed_harvest("wheat", wheat_harvest_scene)
		
		
func trigger_feed_harvest(inventory_item: String,scene: Resource) -> void:
	var inventory: Dictionary= InventoryManager.inventory
	
	if !inventory.has(inventory_item):
		return

	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count:
		var harvest_instance = scene.instantiate() as Node2D
		harvest_instance.global_position = Vector2(global_position.x, global_position.y - food_drop_height)
		get_tree().root.add_child(harvest_instance)
		var target_position = global_position

		var time_delay = randf_range(0.5,2.0)
		await get_tree().create_timer(time_delay).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(harvest_instance, "position", target_position, 1.0)
		tween.tween_property(harvest_instance, "scale", Vector2(0.5, 0.5), 1.0)
		tween.tween_callback(harvest_instance.queue_free)
		
		InventoryManager.remove_collectable(inventory_item)
		
func on_food_received(area: Area2D) -> void:
	call_deferred("add_reward_scene")
	
func add_reward_scene() -> void:
	var total_like_count := 0

	for animal in animals.get_children():
		if animal is NPC:
			total_like_count += animal.like_count
			
	print("Total Like: ", total_like_count)
	
	var is_advanced_reward := total_like_count >= 5

	for scene in output_reward_scenes:
		var final_scene = scene

		if is_advanced_reward:
			if scene == preload("res://scenes/objects/animal_products/normal_milk.tscn") and advanced_milk_scene:
				final_scene = advanced_milk_scene
			elif scene == preload("res://scenes/objects/animal_products/normal_egg.tscn") and advanced_egg_scene:
				final_scene = advanced_egg_scene

		var reward_scene: Node2D = final_scene.instantiate()
		var reward_position: Vector2 = get_random_position_in_circle(reward_marker.global_position, reward_output_radius)
		reward_scene.global_position = reward_position
		get_tree().root.add_child(reward_scene)

	for animal in animals.get_children():
		if animal is NPC:
			animal.like_count -= 1

		
func get_random_position_in_circle(center: Vector2, radius: int) -> Vector2i:
	var angle = randf()* TAU
	var distance_from_center =sqrt(randf())* radius
	var x:int=center.x+ distance_from_center * cos(angle)
	var y: int = center.y+ distance_from_center * cos(angle)
	
	return Vector2i(x , y)
	
