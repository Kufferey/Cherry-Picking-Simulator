extends Node2D

signal _cherry_pick_location_sig(_times:int)

#@export var cherry_on_bush: PackedScene
var cherry_on_bush = preload("res://assets/scenes/prefab/Cherry_onB.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _cherry_pick_location(_times:int) -> void:
#	var Random_position = randi_range(1,5)
#	var Random_position2 = randi_range(1,5)
#	var Random_position3 = randi_range(1,5)
#	var Random_position4 = randi_range(1,5)
	for Times in _times:
		var point1 = $point1.position
		var point2 = $point2.position
		var point3 = $point3.position
		var point4 = $point4.position
		var point5 = $point5.position
		
		var _Random_position = randi_range(1,5)
		var _New_position = 1
		var _Spawn_point = 1
		
		print("Position on '_Random_position' now is: " , _Random_position)
		
		match _Random_position:
			1:
				_New_position = 1
			2:
				_New_position = 2
			3:
				_New_position = 3
			4:
				_New_position = 4
			5:
				_New_position = 5
		
		match _New_position:
			1:
				_Spawn_point = point1
			2:
				_Spawn_point = point2
			3:
				_Spawn_point = point3
			4:
				_Spawn_point = point4
			5:
				_Spawn_point = point5
		
		var Cherry_instance = cherry_on_bush.instantiate()
		
		print("CHERRY LOCATION ADDED.")
		Cherry_instance.position = _Spawn_point
		add_child(Cherry_instance)
