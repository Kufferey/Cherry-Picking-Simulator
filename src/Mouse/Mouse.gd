extends Node2D

class_name Mouse_obj_instance

signal _change_mouse_sig(_new:int)

var mouse_mode = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_change_mouse()
	self.position = get_global_mouse_position()

func _change_mouse_mode_var(_new):
	mouse_mode = _new

func _change_mouse():
	match mouse_mode:
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

func _on__change_mouse_sig(_new) -> void:
	match _new:
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
