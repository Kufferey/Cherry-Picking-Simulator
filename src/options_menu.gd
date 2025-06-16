extends Node2D

var enabledFullScreen:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Data.Player["VoidEnding"]:
		$Buttons/ThemeVoid.show()

func _on_fs_toggled(button_pressed: bool) -> void:
	if (button_pressed == true):
		enabledFullScreen = true
	elif (button_pressed == false):
		enabledFullScreen = false


func _on_show_custom_mouse_toggled(button_pressed: bool) -> void:
	if (button_pressed == true):
		Data.Settings["customMouse"] = true
	elif (button_pressed == false):
		Data.Settings["customMouse"] = false


func _on_apply_pressed() -> void:
	if (enabledFullScreen == true):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Data.isInOptionsMenu = false
	queue_free()


func _on_theme_cherry_pressed() -> void:
	Data.Settings["theme"] = 0
	Data.isInOptionsMenu = false
	queue_free()
	Loading.start_load("res://scenes/mainmenu.tscn")

func _on_theme_void_pressed() -> void:
	Data.Settings["theme"] = 1
	Data.isInOptionsMenu = false
	queue_free()
	Loading.start_load("res://scenes/mainmenu.tscn")
