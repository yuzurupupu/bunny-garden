# NOTE: This script is based on the following tutorial:
# YouTube Tutorial by Rapid Vectors ： https://www.youtube.com/watch?v=it0lsREGdmc&t=207s

extends Timer

@export var audio_stream_player_2D: AudioStreamPlayer2D

func _on_timeout() -> void:
	audio_stream_player_2D.play()
