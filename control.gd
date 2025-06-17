extends Control

var start_point = Vector2(100, 100)
var direction = Vector2(150, 50) # Your vector

func _draw():
	draw_line(start_point, start_point + direction, Color(0, 1, 0), 2) # Draw a green line

func _ready():
	update() # Call update to trigger the _draw function
