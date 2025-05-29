extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractbaleComponent = $InteractableComponent

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactble_deactivated.connect(on_interactable_deactivated)
	collision_layer = 1
	
func on_interactable_activated() -> void:
	animated_sprite_2d.play("open_door")
	collision_layer = 2
	print("ok")
	
func on_interactable_deactivated() -> void:
	animated_sprite_2d.play("close_door")
	collision_layer = 1
	print("no")
