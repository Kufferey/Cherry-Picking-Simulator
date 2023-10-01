extends Node2D

@export var SPEED := 150
@export var curSpeedacc := 55

func _ready() -> void:
	var _Random_image = randi_range(1,2)
	
	match _Random_image:
		1:
			$cherry_1.show()
			$cherry_2.hide()
		2:
			$cherry_2.show()
			$cherry_1.hide()

func _process(delta: float) -> void:
	SPEED += curSpeedacc
	position.y += SPEED * delta
	print($Timer.time_left)

func _on_timer_timeout() -> void:
	queue_free()
