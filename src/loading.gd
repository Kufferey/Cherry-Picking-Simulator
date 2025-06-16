extends CanvasLayer

var particles : Array[GPUParticles2D] = []
#var snap_sfx = preload("res://assets/sound/Cherry_snap.ogg")

func _ready() -> void:
	for part in $loading/Particles.get_children():
		particles.append(part)
	$loading/AnimationPlayer.play("end")

func turn_cherry_flow(x : bool) -> void:
	for i in particles:
		i.emitting = x

func play_snap(x : int, stall_time : float) -> void:
	for i in x:
		
		$loading/AudioStreamPlayer.pitch_scale = randf_range(0.7, 4)
		$loading/AudioStreamPlayer.volume_db = randf_range(-1, 1)
		
		$loading/AudioStreamPlayer.play()
		print("CLICK")
		await get_tree().create_timer(stall_time).timeout

func start_load(scene : String) -> void:
	if Data.isVoidEE or Data.Settings["theme"] == 1:
		var qm = load("res://assets/images/questionmarkb.png")
		$loading/Particles/GPUParticles2D.texture = qm
		$loading/Particles/GPUParticles2D2.texture = qm
		$loading/Particles/GPUParticles2D3.texture = qm
		$loading/Particles/GPUParticles2D4.texture = qm
	else :
		var c = load("res://assets/images/Cherry_1.png")
		var c2 = load("res://assets/images/Cherry_2.png")
		$loading/Particles/GPUParticles2D.texture = c
		$loading/Particles/GPUParticles2D2.texture = c2
		$loading/Particles/GPUParticles2D3.texture = c
		$loading/Particles/GPUParticles2D4.texture = c2
	
	turn_cherry_flow(true)
	play_snap(60, 0.02)
	$loading/AnimationPlayer.play("start")
	await $loading/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene)
	
	$loading/AnimationPlayer.play("end")
	await $loading/AnimationPlayer.animation_finished
	
	turn_cherry_flow(false)

func start_ex() -> void:
	Data.save_player()
	turn_cherry_flow(true)
	play_snap(20, 0.05)
	$loading/AnimationPlayer.play("start")
	await $loading/AnimationPlayer.animation_finished
	
	get_tree().quit(0)
	
	$loading/AnimationPlayer.play("end")
	await $loading/AnimationPlayer.animation_finished
	
	turn_cherry_flow(false)
