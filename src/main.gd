extends Node2D

# PRELOADS
var Dropped_cherry = preload("res://assets/scenes/prefab/cherry_dropped.tscn")
var Pause_menu = preload("res://scenes/pause_menu.tscn")
# INSTANT
var holding_cherry:Node2D

var ee_type_char : Array[String]

func _ready() -> void:
	holding_cherry = $Cherry_hold
	Data.isClicked = true
#	Game_Mouse.hide()
	
	$Cherry_init.emit_signal(
		"_cherry_pick_location_sig",
		2)

func _drop_cherry() -> void:
	if (Data.isPaused == false):
		var dropped_cherry_instance = Dropped_cherry.instantiate()
		dropped_cherry_instance.position = get_global_mouse_position()
		Data.cur_Times += 1
		Data.cur_multi += .99
		Data.score += 7
		if Data.isVoidEE: Data.Player["SCherrys"] += 1
		else : Data.Player["SCherrys"] = 0
		
		Data.Player["Cherrys"] += 1
		Data.Player["Score"] = Data.score
		
		# MOUSE NORMAL
		
		add_child(dropped_cherry_instance)

func _reload_cherry() -> void:
	if (Data.isPaused == false):
		var Cherry_count = $Cherry_init/Cherrys
		var Child = Cherry_count.get_child_count(true)
		
		if (Child < 1):
			
			for i in range(Child):
				var child = Cherry_count.get_child(0)
				Cherry_count.remove_child(child)
				child.queue_free()
				break
				
			$Cherry_init.emit_signal(
				"_cherry_pick_location_sig",
				Data.cur_Times / Data.cur_multi)

func _cherry_timer_main() -> void:
	if (Data.isPaused == false):
		var Cherry_count = $Cherry_init/Cherrys
		var Child = Cherry_count.get_child_count(false)
		
		if (Child < 1):
			await (get_tree().create_timer(0.5, false, false, false).timeout)
			ee_clear()
			_reload_cherry()

func _process(_delta: float) -> void:
	if (Data.isPaused == false):
		_cherry_timer_main()
		holding_cherry.position = get_global_mouse_position()
		if (Data.isHoldingCherry == true):
			holding_cherry.show()
			if (Data.isClicked == true):
				$Cherry_init/AudioStreamPlayer2D.play(0.0)
				# MOUSE GRAB
				Game_Mouse.get_child(0).mouse_entered = false
				Game_Mouse.get_child(0).emit_signal("_change_mouse_sig", 2)
				Data.isClicked = false
		elif (Data.isHoldingCherry == false):
			holding_cherry.hide()
			# MOUSE NORMAL
			Game_Mouse.get_child(0).emit_signal("_change_mouse_sig", 0)
			
			
		if (Data.isPaused == false && Input.is_action_just_pressed("exit")):
			var pause_menu_instance = Pause_menu.instantiate()
			Data.isPaused = true
			add_child(pause_menu_instance)
		
		$Cherry_hold.emit_signal(
			"look_for_cherry_model")

func ee_clear() -> void:
	await get_tree().create_timer(8).timeout
	print("EE Cleared")
	ee_type_char.clear()

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
		if event.is_released():
			ee_type_char.append(OS.get_keycode_string(event.keycode))
	
		if !Data.voidEEComp:
			match ee_type_char:
				["H", "O", "V", "E", "R"]:
					Data.isHoverEE = true
				["S", "O", "N", "G"]:
					$AudioStreamPlayer.stream = load("res://assets/music/secret.ogg")
					$AudioStreamPlayer.play()
				["V", "O", "I", "D"]:
					if !Data.voidPart == 3:
						DisplayServer.window_set_title("You can't be here.")
						Game_Mouse.hide()
						Loading.start_load("res://scenes/void.tscn")
				Data.voidEEsecret:
					if Data.voidEEsecretEnter:
						Data.voidEEEnteredCode = true
						Data.voidPart = 0
						Data.voidEEsecretEnter = true
						DisplayServer.window_set_title("Finally...")
						Game_Mouse.hide()
						Loading.start_load("res://scenes/void.tscn")
	
	if (Data.isPaused == false):
		if (Input.is_action_just_pressed("get_cherry")):
			if (Data.isHoldingCherry == true):
				Data.isHoldingCherry = false
				Data.isClicked = true
				_drop_cherry()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play(0)
