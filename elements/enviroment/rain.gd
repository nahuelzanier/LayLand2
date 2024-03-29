extends TextureRect

var rainfall_speed = 50
var rainfall_direction = Vector2(1,2)

var rain_starting_pos
var rainfall

@export var rain_destroy_position_x= 0
@export var rain_destroy_position_y = 0

func _process(delta):
	position += rainfall_direction * rainfall_speed * delta
	if position.y > rain_destroy_position_y || position.x > rain_destroy_position_x:
		position = Vector2(-100, -200)
		
		
