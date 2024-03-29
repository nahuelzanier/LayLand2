extends Node2D

var state_manager
var last_direction = Vector2(0,1)

func _process(_delta):
	var vertical = Input.get_axis("up", "down")
	var horizontal = Input.get_axis("left", "right")
	if vertical || horizontal:
		var direction = Vector2(horizontal*2, vertical).normalized()
		state_manager.update_velocity(direction)
		play_animation(horizontal, vertical)
		last_direction = direction
	else:
		state_manager.update_velocity(Vector2(horizontal*2, vertical).normalized())
		state_manager.change_state("lift", last_direction)
	if Input.is_action_just_pressed("left_click"):
		state_manager.manage_lift(get_global_mouse_position())

func play_animation(h, v):
	if h == 0 && v < 0:
		state_manager.animations.animation = "liftwalk_north"
	elif h == 0 && v > 0:
		state_manager.animations.animation = "liftwalk_south"
	elif h < 0 && v == 0:
		state_manager.animations.animation = "liftwalk_west"
	elif h > 0 && v == 0:
		state_manager.animations.animation = "liftwalk_east"
	elif h > 0 && v < 0:
		state_manager.animations.animation = "liftwalk_north_east"
	elif h > 0 && v > 0:
		state_manager.animations.animation = "liftwalk_south_east"
	elif h < 0 && v < 0:
		state_manager.animations.animation = "liftwalk_north_west"
	elif h < 0 && v > 0:
		state_manager.animations.animation = "liftwalk_south_west"
	state_manager.animations.play()
