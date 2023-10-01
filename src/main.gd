extends Node2D
# PRELOADS
var Dropped_cherry = preload("res://assets/scenes/prefab/cherry_dropped.tscn")
var Cherry_onbush_sprite = preload("res://assets/scenes/prefab/Cherry_onB.tscn")
# BOOLS
var isHoldingCherry:bool = false
# INTS
var curHoldingState:int = 0
# INSTANT
var holding_cherry_instance = Cherry_onbush_sprite.instantiate()

func _ready() -> void:
	pass

func _drop_cherry() -> void:
	var dropped_cherry_instance = Dropped_cherry.instantiate()
	dropped_cherry_instance.position = get_global_mouse_position()
	isHoldingCherry = false
	curHoldingState = 0
	add_child(dropped_cherry_instance)

func _check_cherry_hold():
	if (isHoldingCherry && curHoldingState == 1):
		add_child(holding_cherry_instance)

func _process(delta: float) -> void:
	_check_cherry_hold()
	if (Input.is_action_just_pressed("ui_right") && curHoldingState == 0 && !isHoldingCherry):
		remove_child(holding_cherry_instance)
		_drop_cherry()
		
	holding_cherry_instance.position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_down")):
		curHoldingState = 1
		isHoldingCherry = true
	elif (Input.is_action_just_pressed("ui_up")):
		curHoldingState = 0
		isHoldingCherry = false
	elif (Input.is_action_just_pressed("ui_left")):
		curHoldingState = 1
		isHoldingCherry = false
