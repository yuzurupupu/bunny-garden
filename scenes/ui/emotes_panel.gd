extends Panel

@onready var emote_sprite: AnimatedSprite2D = $Emotes/AnimatedSprite2D
@onready var idle_timer: Timer = $EmoteIdleTimer

const IDLE_EMOTES := [
	"emote_1_idle",
	"emote_2_smile", 
	"emote_3_ear_wave",
	"emote_4_blink"
]

func _ready() -> void:
	emote_sprite.play(IDLE_EMOTES[0])
	idle_timer.timeout.connect(_on_idle_emote)
	
	InventoryManager.inventory_changed.connect(_on_inventory_changed)
	GameDialogueManager.feed_the_animals.connect(_on_feed_animals)

func play_emote(animation: String) -> void:
	emote_sprite.play(animation)

func _on_idle_emote() -> void:
	play_emote(IDLE_EMOTES.pick_random())

func _on_inventory_changed() -> void:
	play_emote("emote_7_excited")

func _on_feed_animals() -> void:
	play_emote("emote_6_love_kiss")
