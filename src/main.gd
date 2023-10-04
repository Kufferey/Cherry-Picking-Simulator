extends Node2D

class_name main

# PRELOADS
var mouse
var Dropped_cherry = preload("res://assets/scenes/prefab/cherry_dropped.tscn")
var Cherry_onbush_sprite = preload("res://assets/scenes/prefab/Cherry_onB.tscn")
# INSTANT
var holding_cherry

func _ready() -> void:
	mouse = $Mouse
	holding_cherry = $Cherry_hold
	Data.isClicked = true

func _drop_cherry() -> void:
	var dropped_cherry_instance = Dropped_cherry.instantiate()
	dropped_cherry_instance.position = get_global_mouse_position()
	Data.cur_Times += 1
	Data.score += 7
	add_child(dropped_cherry_instance)

func _check_cherry_hold():
	if (Data.isHoldingCherry == true):
		return true
	elif (Data.isHoldingCherry == false):
		return false

func _process(delta: float) -> void:
	holding_cherry.position = get_global_mouse_position()
	if (Data.isHoldingCherry == true):
		holding_cherry.show()
		if (Data.isClicked == true):
			$Cherry_init/AudioStreamPlayer2D.play(0.0)
			Data.isClicked = false
	elif (Data.isHoldingCherry == false):
		holding_cherry.hide()

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("get_cherry")):
		if (Data.isHoldingCherry == true):
			Data.isHoldingCherry = false
			Data.isClicked = true
			_drop_cherry()

func _on_button_pressed() -> void:
	var Cherry_count = $Cherry_init/Cherrys
	var Child = Cherry_count.get_child_count(true)
	$Cherry_init.emit_signal("_cherry_pick_location_sig", Data.cur_Times)
	
	for i in range(Child):
		var child = Cherry_count.get_child(0)
		Cherry_count.remove_child(child)
		child.queue_free()
