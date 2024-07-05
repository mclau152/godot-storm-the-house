extends Node2D

var Enemy = preload("res://Enemy.tscn")
var screen_size: Vector2

var score: int = 0
@onready var score_label = $ScoreLabel


func _ready():
	screen_size = get_viewport_rect().size
	var spawn_timer = Timer.new()
	spawn_timer.set_wait_time(randf_range(.3, .6))  # Random time between spawns
	spawn_timer.one_shot = false  # Set it to repeat
	spawn_timer.connect("timeout", Callable(self, "_on_SpawnTimer_timeout"))
	add_child(spawn_timer)
	spawn_timer.start()
	update_score_label()
	
func increase_score():
	score += 1
	update_score_label()

func update_score_label():
	score_label.text = "Score: %d" % score

func _process(delta):
	var all_destroyed = true
	for node in get_tree().get_nodes_in_group("enemies"):
		all_destroyed = false
		break

	#if all_destroyed:
		#OS.alert("congrats!")
		#get_tree().quit()

func _on_SpawnTimer_timeout():
	var enemy_instance = Enemy.instantiate()
	enemy_instance.position = Vector2(0, randf_range(0, screen_size.y))
	add_child(enemy_instance)
	
	# Restart the timer with a new random interval
	var spawn_timer = get_node("SpawnTimer")
	spawn_timer.set_wait_time(randf_range(.2, 3))
	spawn_timer.start()


