extends Node2D

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
	
	$Cherry_init.emit_signal(
		"_cherry_pick_location_sig",
		2)

func _drop_cherry() -> void:
	var dropped_cherry_instance = Dropped_cherry.instantiate()
	dropped_cherry_instance.position = get_global_mouse_position()
	Data.cur_Times += 1
	Data.cur_multi += .99
	Data.score += 7
	add_child(dropped_cherry_instance)

func _reload_cherry() -> void:
	var Cherry_count = $Cherry_init/Cherrys
	var Child = Cherry_count.get_child_count(true)
	
	if (Child < 1):
		
		for i in range(Child):
			var child = Cherry_count.get_child(0)
			Cherry_count.remove_child(child)
			child.queue_free()
			
		$Cherry_init.emit_signal(
			"_cherry_pick_location_sig",
			Data.cur_Times / Data.cur_multi)

func _cherry_timer_main() -> void:
	var Cherry_count = $Cherry_init/Cherrys
	var Child = Cherry_count.get_child_count(false)
	
	if (Child < 1):
		await (get_tree().create_timer(0.5, false, false, false).timeout)
		_reload_cherry()

func _process(delta: float) -> void:
	_cherry_timer_main()
	holding_cherry.position = get_global_mouse_position()
	if (Data.isHoldingCherry == true):
		holding_cherry.show()
		if (Data.isClicked == true):
			$Cherry_init/AudioStreamPlayer2D.play(0.0)
			Data.isClicked = false
	elif (Data.isHoldingCherry == false):
		holding_cherry.hide()
	
	$Cherry_hold.emit_signal("look_for_cherry_model")

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("get_cherry")):
		if (Data.isHoldingCherry == true):
			Data.isHoldingCherry = false
			Data.isClicked = true
			_drop_cherry()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play(0)
