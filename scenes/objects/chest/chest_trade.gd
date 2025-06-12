extends Node2D

var ballon_scene = preload("res://dialogue/game_dialogue_ballon.tscn")
var gold_reward_scene = preload("res://scenes/objects/gold_coin.tscn")

@onready var interactable_component: InteractbaleComponent = $InteractableComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var feed_component: FeedComponent = $FeedComponent
@onready var reward_marker: Marker2D = $RewardMarker
@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var label: Label = $Label

@export var dialogue_start_command: String
@export var food_drop_height: int = 40
@export var reward_output_radius: int = 20
@export var sell_item_scenes: PackedScene
@export var sell_item_name: String = "Item" 
@export var gold_reward_amount: int = 1

var in_range: bool
var is_chest_open: bool

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	label.text = "Sell " + sell_item_name + " Here"
	label.hide()
	
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	feed_component.food_received.connect(on_food_received)

func on_interactable_activated() -> void:
	interactable_label_component.show()
	label.show()
	in_range = true

func on_interactable_deactivated() -> void:
	if is_chest_open:
		animated_sprite_2d.play("chest_close")
		
	is_chest_open = false
	interactable_label_component.hide()
	label.hide()
	in_range = false
	
func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("show_dialogue"):
			interactable_label_component.hide()
			label.hide()
			animated_sprite_2d.play("chest_open")
			is_chest_open = true
			
			var ballon: BaseGameDialogueBallon = ballon_scene.instantiate()
			get_tree().root.add_child(ballon)
			ballon.start(load("res://dialogue/conversations/trade.dialogue"), dialogue_start_command)
			
func on_feed_the_animals() -> void:
	if in_range:
		trigger_sell_item(sell_item_scenes)
		
func trigger_sell_item(scene: Resource) -> void:
	var inventory: Dictionary = InventoryManager.inventory
	var item_name = sell_item_name.to_lower()
	
	if !inventory.has(item_name):
		return

	var inventory_item_count = inventory[item_name]
	
	for index in inventory_item_count:
		# Spawn the item being sold
		var item_instance = scene.instantiate() as Node2D
		item_instance.global_position = Vector2(global_position.x, global_position.y - food_drop_height)
		get_tree().root.add_child(item_instance)
		var target_position = global_position

		var time_delay = randf_range(0.5, 2.0)
		await get_tree().create_timer(time_delay).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(item_instance, "position", target_position, 1.0)
		tween.tween_property(item_instance, "scale", Vector2(0.5, 0.5), 1.0)
		tween.tween_callback(item_instance.queue_free)
		
		# Remove from inventory
		InventoryManager.remove_collectable(item_name)
		
		# Add gold reward
		for i in range(gold_reward_amount):
			var gold_instance = gold_reward_scene.instantiate() as Node2D
			var reward_position: Vector2 = get_random_position_in_circle(reward_marker.global_position, reward_output_radius)
			gold_instance.global_position = reward_position
			get_tree().root.add_child(gold_instance)
		
func on_food_received(area: Area2D) -> void:
	pass  # No additional rewards needed since we handle it in trigger_sell_item

func get_random_position_in_circle(center: Vector2, radius: int) -> Vector2i:
	var angle = randf() * TAU
	var distance_from_center = sqrt(randf()) * radius
	var x: int = center.x + distance_from_center * cos(angle)
	var y: int = center.y + distance_from_center * sin(angle)  # Fixed typo (was cos for y)
	
	return Vector2i(x, y)
