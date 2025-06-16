extends Node2D

var sec : int = 0
var random = [
	"NEWCODE",
	"ENTRY44",
	"HOTLINE",
	"COMPANYMESSAGE5637",
	"BARLINE",
	"CONFINEDBOX",
	"REQUEST687",
	"CELL",
	"IMWATCHING",
	"TODAYISSALVATION",
]
var random_sel

func play_snap(x : int, stall_time : float) -> void:
	for i in x:
		
		$loading/AudioStreamPlayer.pitch_scale = randf_range(0.7, 4)
		$loading/AudioStreamPlayer.volume_db = randf_range(-1, 1)
		
		$loading/AudioStreamPlayer.play()
		print("CLICK")
		await get_tree().create_timer(stall_time).timeout

func new_sec_alter():
	sec += 1
	
	match sec:
		1:
			play_snap(15, 0.2)
			$ColorRect/Label.text = "Finally..."
		2:
			play_snap(10, 0.2)
			$ColorRect/Label.text = "I'm free."
		3:
			play_snap(15, 0.2)
			$ColorRect/Label.text = "Thank you."
		4:
			play_snap(25, 0.2)
			$ColorRect/Label.text = "Thank you, for swaping places with me."
		5:
			Data.voidEEComp = true
			Loading.start_load("res://scenes/mainmenu.tscn")
			Data.Player["VoidEnding"] = true
			Game_Mouse.show()
			return


func new_sec():
	sec += 1
	
	if !Data.isVoidEE:
		match sec:
			1:
				play_snap(15, 0.2)
				Data.Player["SCherrys"] = 0
				$ColorRect/Label.text = "You got to leave."
			2:
				play_snap(19, 0.1)
				$ColorRect/Label.text = "I will put you elsewhere."
			3:
				play_snap(7, 0.09)
				$ColorRect/Label.text = "Don't leave and play normally."
			4:
				random_sel = random.pick_random()
				
				play_snap(10, 0.1)
				$ColorRect/Label.text = "Code is: " + random_sel
			5:
				play_snap(10, 0.2)
				$ColorRect/Label.text = "Oh, can you bring me exactly 7 cherries next time?\nFood supply is running low."
		
		if sec == 6:
			for i in random_sel:
				Data.voidEEsecret.append(i)
			
			Data.voidPart += 1
			Data.isVoidEE = true
			DisplayServer.window_set_title("Is this the same?")
			Loading.start_load("res://scenes/mainmenu.tscn")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			Game_Mouse.show()
	else :
		match sec:
			1:
				play_snap(15, 0.2)	
				$ColorRect/Label.text = "Oh, you came back?"
			2:
				play_snap(19, 0.1)
				if Data.Player["SCherrys"] == 7:
					$ColorRect/Label.text = "Thanks for the food.\nIts been 12 days. Hard to breathe in here."
				else :
					$ColorRect/Label.text = "Thanks for trying to get the food.\nI understand you couldn't."
			3:
				play_snap(7, 0.09)
				if Data.Player["SCherrys"] == 7:
					$ColorRect/Label.text = "Here,\nI'm giving you access to this new area."
				else : $ColorRect/Label.text = "Please try harder next time."
			4:
				random_sel = null
				
				if !Data.Player["SCherrys"] == 7:
					Data.isVoidEE = false
					Data.voidPart = 0
					Game_Mouse.show()
					Loading.start_load("res://scenes/mainmenu.tscn")
					return
					
				play_snap(10, 0.1)
				$ColorRect/Label.text = "Be careful though, its dangerous."
			5:
				play_snap(10, 0.2)
				$ColorRect/Label.text = "Be safe.\nAnd remember the code i gave you?\nUse it."
		
		if sec == 6:
			sec = 5
			Data.voidPart += 1
			Data.voidEEsecretEnter = true
			DisplayServer.window_set_title("Hunting Simulator")
			Loading.start_load("res://scenes/mainmenu.tscn")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			Game_Mouse.show()

func _ready() -> void:
	if Data.voidPart == 2:
		play_snap(15, 0.2)
		$ColorRect/Label.text = "Use it."
		Game_Mouse.show()
		Loading.start_load("res://scenes/main.tscn")
		
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$Timer.connect("timeout", func ():
		$Timer.start()
		
		if !Data.voidEEEnteredCode and !Data.voidEEsecretEnter:
			new_sec()
		else :
			new_sec_alter()
			
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
