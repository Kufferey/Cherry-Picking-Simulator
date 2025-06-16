extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_pause_menu_stuff_remove_self() -> void:
	queue_free()
