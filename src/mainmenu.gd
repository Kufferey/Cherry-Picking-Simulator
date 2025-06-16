extends Node2D

var Options_Menu = preload("res://scenes/options_menu.tscn")

func _on_play_pressed() -> void:
	Loading.start_load("res://scenes/main.tscn")

func _on_exit_pressed() -> void:
	Loading.start_ex()

func _on_options_pressed() -> void:
	Data.isInOptionsMenu = true
	
	var Options_menu_instance = Options_Menu.instantiate()
	add_child(Options_menu_instance)

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play(0)

func _process(_delta: float) -> void:
	if (Data.isInOptionsMenu == true):
		$Buttons.hide()
	else :
		$Buttons.show()

func set_theme(x : int):
	match x:
		1:
			var qm = load("res://assets/images/questionmark.png")
			for i in $PALBG/ParallaxBackground_BACK/ParallaxLayer.get_children():
				i.texture = qm
			for i in $PALBG/ParallaxBackground_BACK_DARK/ParallaxLayer.get_children():
				i.texture = qm
			for i in $PALBG/ParallaxBackground_BACK_MIDDLE/ParallaxLayer.get_children():
				i.texture = qm
			for i in $PALBG/ParallaxBackground_FRONT/ParallaxLayer2.get_children():
				i.texture = qm
			
			$AudioStreamPlayer.stream = load("res://assets/music/secret.ogg")
			$AudioStreamPlayer.pitch_scale = 0.25
			$AudioStreamPlayer.play()
			
			

func _ready() -> void:
	if !Data.hasLoadedSave:
		Data.get_player()
		Data.hasLoadedSave = true
		
	if Data.isVoidEE || Data.Settings["theme"] == 1:
		$Logo.hide()
		$PALBG.hide()
		
		set_theme(1)
		
		var qm = load("res://assets/images/questionmark.png")
		for i in $PALBG/ParallaxBackground_BACK/ParallaxLayer.get_children():
			i.texture = qm
		for i in $PALBG/ParallaxBackground_BACK_DARK/ParallaxLayer.get_children():
			i.texture = qm
		for i in $PALBG/ParallaxBackground_BACK_MIDDLE/ParallaxLayer.get_children():
			i.texture = qm
		for i in $PALBG/ParallaxBackground_FRONT/ParallaxLayer2.get_children():
			i.texture = qm
		
		$AudioStreamPlayer.stream = load("res://assets/music/secret.ogg")
		$AudioStreamPlayer.pitch_scale = 0.25
		$AudioStreamPlayer.play()
		
		if Data.voidEEComp:
			$AudioStreamPlayer.stream = load("res://assets/music/elert.ogg")
			$AudioStreamPlayer.pitch_scale = 0.2
			$AudioStreamPlayer.play()
