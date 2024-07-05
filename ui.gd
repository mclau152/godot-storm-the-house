extends Control  # Adjust as necessary, e.g., if it's attached to a Node2D

@onready var health_bar = $ProgressBar  # Replace with the correct path to your health bar node
var decrease_rate = 10  # 10% per second per enemy
var active_enemies = 0

func _process(delta):
	if active_enemies > 0:
		health_bar.value -= decrease_rate * active_enemies * delta
		if health_bar.value <= 0:
			health_bar.value = 0
			
			OS.alert("Game Over!")
			get_tree().quit()

func start_decreasing_health():
	active_enemies += 1

func stop_decreasing_health():
	active_enemies = max(0, active_enemies - 1)
