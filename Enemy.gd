extends Area2D

var Particle = preload("res://Particle.tscn")
var ProjectileParticle = preload("res://ProjectileParticle.tscn")  
var screen: Rect2
var velocity: Vector2 = Vector2()
var is_damaging = false
var particle_timer: Timer

func _ready():
	randomize()
	screen = get_viewport_rect()
	
	velocity.x = randf_range(50, 200)
	velocity.y = randf_range(0, 0)
	
	add_to_group("enemies")
	
	particle_timer = Timer.new()
	particle_timer.set_wait_time(.5) 
	particle_timer.set_one_shot(false)
	particle_timer.connect("timeout", Callable(self, "_on_particle_timer_timeout"))
	add_child(particle_timer)

func _process(delta):
	position += velocity * delta
	
	if position.x >= 600 and not is_damaging:
		velocity.x = 0
		velocity.y = 0
		start_damage()
	elif position.x < 600 and is_damaging:
		stop_damage()

func start_damage():
	is_damaging = true
	var ui_scene = get_ui_scene()
	if ui_scene:
		ui_scene.start_decreasing_health()
	particle_timer.start()

func stop_damage():
	is_damaging = false
	var ui_scene = get_ui_scene()
	if ui_scene:
		ui_scene.stop_decreasing_health()
	particle_timer.stop()

func get_ui_scene():
	var main_scene = get_tree().current_scene
	return main_scene.find_child("ui", true, false)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		var main_scene = get_tree().root.get_node("Main")
		main_scene.increase_score()
		
		if is_damaging:
			stop_damage()
		
		queue_free()
		
		var p = Particle.instantiate()
		p.start(position)
		
		var root_node = get_parent()
		root_node.add_child(p)

func _on_particle_timer_timeout():
	emit_projectile_particle()

func emit_projectile_particle():
	var p = ProjectileParticle.instantiate()
	p.position = position
	p.velocity = Vector2(100, 0)  # Adjust speed as needed
	get_parent().add_child(p)
