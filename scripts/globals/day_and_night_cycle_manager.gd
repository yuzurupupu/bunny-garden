extends Node

const MINUTES_PER_DAY := 1440
const MINUTES_PER_HOUR := 60
const GAME_MINUTE_DURATION := TAU / MINUTES_PER_DAY

var game_speed := 5.0
@export var initial_day := 1
@export var initial_hour := 12
@export var initial_minute := 30

var time := 0.0
var current_minute := -1
var current_day := 0

signal game_time_changed(time: float)
signal minute_changed(day: int, hour: int, minute: int)
signal day_changed(day: int)

func _ready() -> void:
	reset_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time_changed.emit(time)
	update_time()

func reset_time() -> void:
	time = (initial_day * MINUTES_PER_DAY + initial_hour * MINUTES_PER_HOUR + initial_minute) * GAME_MINUTE_DURATION

func update_time() -> void:
	var total_minutes := int(time / GAME_MINUTE_DURATION)
	var day := total_minutes / MINUTES_PER_DAY
	var day_minutes := total_minutes % MINUTES_PER_DAY
	var hour := day_minutes / MINUTES_PER_HOUR
	var minute := day_minutes % MINUTES_PER_HOUR

	if current_minute != minute:
		current_minute = minute
		minute_changed.emit(day, hour, minute)
	
	if current_day != day:
		current_day = day
		day_changed.emit(day)
