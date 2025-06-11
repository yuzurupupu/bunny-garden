extends PanelContainer
@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stones/StoneLabel
@onready var corn_label: Label = $MarginContainer/VBoxContainer/Corn/CornLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/Tomatos/TomatoLabel
@onready var carrot_label: Label = $MarginContainer/VBoxContainer/Carrots/CarrotLabel
@onready var wheat_label: Label = $MarginContainer/VBoxContainer/Wheat/WheatLabel
@onready var advanced_egg_label: Label = $MarginContainer/VBoxContainer/AdvancedEggs/AdvancedEggLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Eggs/EggLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel
@onready var advanced_milk_label: Label = $MarginContainer/VBoxContainer/AdvancedMilk/AdvancedMilkLabel


func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	
func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = str(inventory["log"])
		
	if inventory.has("stone"):
		stone_label.text = str(inventory["stone"])
		
	if inventory.has("corn"):
		corn_label.text = str(inventory["corn"])
		
	if inventory.has("tomato"):
		tomato_label.text = str(inventory["tomato"])
		
	if inventory.has("egg"):
		egg_label.text = str(inventory["egg"])
		
	if inventory.has("milk"):
		milk_label.text = str(inventory["milk"])
		
	if inventory.has("carrot"):
		carrot_label.text = str(inventory["carrot"])
		
	if inventory.has("wheat"):
		wheat_label.text = str(inventory["wheat"])
		
	if inventory.has("advanced_egg"):
		advanced_egg_label.text = str(inventory["advanced_egg"])
		
	if inventory.has("advanced_milk"):
		advanced_milk_label.text = str(inventory["advanced_milk"])
