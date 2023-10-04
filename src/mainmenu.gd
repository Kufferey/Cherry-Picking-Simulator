extends Node2D

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit(0)

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play(0)
