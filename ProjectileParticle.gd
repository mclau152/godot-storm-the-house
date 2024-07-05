extends Sprite2D

var velocity = Vector2.ZERO

func _ready():
	texture = load("res://icon.svg")
	scale = Vector2(0.25, 0.25)  # Adjust size as needed

func _process(delta):
	position += velocity * delta
	
	# Remove the particle when it's off-screen
	if position.x > 900:
		queue_free()
