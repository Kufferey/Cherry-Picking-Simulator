extends Node

# BOOLS
var isHoldingCherry:bool = false
var isClicked:bool = false
var isPaused:bool = false
var isInCombo:bool = false
var isInOptionsMenu:bool = false

var hasLoadedSave:bool
## EE
var isHoverEE:bool = false
var voidEEsecret:Array[String]
var voidEEsecretEnter:bool
var isVoidEE:bool
var voidPart:int = 0
var voidEEEnteredCode:bool = false
var voidEEComp:bool
# INTS
var score:int = 0
var cur_Times:int = 0
var cur_multi:int = 1
var curCherryModel:int = 1
# PLAYER SAVE
var Player:Dictionary = {
	"Score": 0,
	"SCherrys": 0,
	"Cherrys": 0,
	
	"VoidEnding": false,
	
	"Upgrades": {
		"ScoreMulti": 0,
		"HungerMulti": 0,
		"RoughnessMulti": 0
	}
}
# SETTINGS
var Settings:Dictionary = {
	"customMouse": true,
	"fullScreen": false,
	"theme": 0
}

var saved_player

func save_player():
	var data_to_send = JSON.stringify(Player)
	var f = FileAccess.open("user://player_save.json", FileAccess.WRITE)
	
	f.store_string(data_to_send)
	saved_player = data_to_send
	
	f.close()

func get_player():
	
	if !FileAccess.file_exists("user://player_save.json"):
		return
	
	var f = FileAccess.open("user://player_save.json", FileAccess.READ)
	var a = f.get_as_text()
	var data = JSON.parse_string(a)
	
	f.close()
	
	var json = JSON.new()
	var error = json.parse(str(data))
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			Player = Dictionary(data_received)
			print(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", saved_player, " at line ", json.get_error_line())
		
	
	score = Player["Score"]
