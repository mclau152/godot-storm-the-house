extends CPUParticles2D

func start(pos):
	# 
	emitting = true
	# 
	position = pos

func _process(delta):
	if emitting == false:
		
		queue_free()
