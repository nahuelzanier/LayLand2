extends Node2D

var state_manager
var last_direction = Vector2(0,1)

func _ready():
	play_animation(last_direction.x, last_direction.y)

func _process(_delta):
	var vertical = Input.get_axis("up", "down")
	var horizontal = Input.get_axis("left", "right")
	if vertical || horizontal:
		var direction = Vector2(horizontal*2, vertical).normalized()
		state_manager.update_velocity(direction)
		state_manager.change_state("walk", direction)
	if Input.is_action_just_pressed("left_click"):
		state_manager.manage_lift(get_global_mouse_position())

func play_animation(h, v):
	var angle = Vector2(h,-v).angle() + PI/6
	if angle > 2*PI:
		angle = angle - PI
	if angle<=7*PI/8 && angle>=5*PI/8:
		state_manager.animations.animation = "idle_north"
	elif angle<=-PI/8 && angle>=-3*PI/8:
		state_manager.animations.animation = "idle_south"
	elif angle>=-7*PI/8 && angle<=-5*PI/8:
		state_manager.animations.animation = "idle_west"
	elif angle>=PI/8 && angle<=3*PI/8:
		state_manager.animations.animation = "idle_east"
	elif angle>7*PI/8 || angle<-7*PI/8:
		state_manager.animations.animation = "idle_north_west"
	elif angle>-5*PI/8 && angle<-3*PI/8:
		state_manager.animations.animation = "idle_south_west"
	elif angle<5*PI/8 && angle>3*PI/8: 
		state_manager.animations.animation = "idle_north_east"
	elif angle<PI/8 && angle>-PI/8:
		state_manager.animations.animation = "idle_south_east"
	state_manager.animations.play()
