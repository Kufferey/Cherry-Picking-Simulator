extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_change_mouse()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = get_global_mouse_position()

func _change_mouse(_new_mouse_image:int=0):
	match _new_mouse_image:
		0:
			$Mouse_textures/Normal.show()
			$Mouse_textures/Open.hide()
			$Mouse_textures/Grab.hide()
		1:
			$Mouse_textures/Normal.hide()
			$Mouse_textures/Open.show()
			$Mouse_textures/Grab.hide()
		2:
			$Mouse_textures/Normal.hide()
			$Mouse_textures/Open.hide()
			$Mouse_textures/Grab.show()
		_:
			$Mouse_textures/Normal.show()
			$Mouse_textures/Open.hide()
			$Mouse_textures/Grab.hide()
