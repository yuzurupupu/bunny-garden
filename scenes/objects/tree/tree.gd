extends Sprite2D

@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent

@export var log_count: int = 1
var log_scene = preload("res://scenes/objects/tree/log.tscn")

func  _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	
func on_max_damage_reached() -> void:
	call_deferred("add_log_scene")
	print("fall down")
	queue_free()

func add_log_scene() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(log_count):
		var log_instance = log_scene.instantiate() as Node2D
		var offset = Vector2(rng.randf_range(-20, 20), rng.randf_range(-10, 10))
		log_instance.global_position = global_position + offset
		get_parent().add_child(log_instance)
