extends CharacterBody2D

const SPEED = 80
@onready var block_held = $BlockHeld
@onready var state_manager = $StateManager
@onready var feet_position = $FeetPosition
@onready var ground_position = $GroundPosition
@onready var animated_sprite_2d = $AnimatedSprite2D
var climbing = false
var previous_iso_ground_loc = Vector2i.ZERO
var prev_pos = Vector2(0,0)
var current_colission_layer = 1
var reset_position = false
var just_reseted = false

func _ready():
	for i in range(0,16):
		layer_up(1)
	GameGlobal.player = self
	set_collision_layer_value(current_colission_layer, true)
	set_collision_mask_value(current_colission_layer, true)

func _physics_process(delta):
	var ground_iso = IsometricConverter._pos_to_iso(ground_position.global_position)
	var iso_ground_loc = IsometricConverter.cursor_shift(IsometricConverter.vector_shift(ground_iso))
	if not climbing:
		if GameGlobal.render_layers.has(iso_ground_loc):
			if GameGlobal.render_layers[iso_ground_loc].top() < current_colission_layer-2:
				climbing = true
				layer_up(-1)
				$ClimbingTimer.start()
				alter_collisions(iso_ground_loc, current_colission_layer+1, current_colission_layer)
	if reset_position:
		desactivate_collisions(current_colission_layer)
		var ground_corr = IsometricConverter._pos_to_iso(ground_position.global_position)
		previous_iso_ground_loc = IsometricConverter.cursor_shift(IsometricConverter.vector_shift(ground_corr))
		reset_position = false
		climbing = false
		just_reseted = true
	elif just_reseted && prev_pos != position:
		just_reseted = false
		activate_collisions(iso_ground_loc, current_colission_layer)
	elif iso_ground_loc != previous_iso_ground_loc:
		alter_collisions(iso_ground_loc, current_colission_layer, current_colission_layer)
		GameGlobal.camera_manager.update_map(iso_ground_loc-previous_iso_ground_loc)
		previous_iso_ground_loc = iso_ground_loc
	prev_pos = position
	move_and_collide(velocity*delta)

func z_transform(z):
	$AnimatedSprite2D.position.y -= z*IsometricConverter.ISO_HEIGHT/2
	$BlockHeld.position.y -= z*IsometricConverter.ISO_HEIGHT/2
	$CollisionPolygon2D.position.y -= z*IsometricConverter.ISO_HEIGHT/2
	$FeetPosition.position.y -= z*IsometricConverter.ISO_HEIGHT/2

func layer_up(z):
	if (current_colission_layer < 32 or z<0) and (current_colission_layer > 1 or z>0):
		z_transform(z)
		set_collision_layer_value(current_colission_layer, false)
		set_collision_mask_value(current_colission_layer, false)
		current_colission_layer += z
		set_collision_layer_value(current_colission_layer, true)
		set_collision_mask_value(current_colission_layer, true)

func _on_state_manager_change_velocity(vector2):
	velocity.x = move_toward(velocity.x, vector2.x*SPEED, SPEED)
	velocity.y = move_toward(velocity.y, vector2.y*SPEED, SPEED)

func _on_state_manager_player_lift(mouse_position):
	var iso_mouse = IsometricConverter._pos_to_iso(mouse_position + Vector2(0, (current_colission_layer-2)*IsometricConverter.ISO_HEIGHT/2))
	var iso_loc = IsometricConverter.cursor_shift(IsometricConverter.vector_shift(iso_mouse))
	if GameGlobal.render_layers.has(iso_loc):
		block_held.block_held.player_unlift_action(iso_loc)
		activate_collisions(previous_iso_ground_loc, current_colission_layer)

func _on_state_manager_player_climb(mouse_position):
	if not climbing:
		climbing = true
		layer_up(1)
		$ClimbingTimer.start()
		alter_collisions(previous_iso_ground_loc, current_colission_layer-1, current_colission_layer)

func _on_climbing_timer_timeout():
	climbing = false

func iso_pos():
	var ground_iso = IsometricConverter._pos_to_iso(ground_position.global_position)
	return ground_iso

func alter_collisions(new_loc, old_col_layer, new_col_layer): 
	desactivate_collisions(old_col_layer)
	activate_collisions(new_loc, new_col_layer)

func activate_collisions(new_loc, col_layer):
	var adjacent_tiles = [Vector2i(0,0), Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1), Vector2i(1,1), Vector2i(-1,1), Vector2i(-1,-1), Vector2i(1,-1)]
	for v in adjacent_tiles:
		if GameGlobal.render_layers.has(new_loc + v):
			var new_col = GameGlobal.render_layers[new_loc + v].column[col_layer-1]
			if not new_col.block == null:
				new_col.block.enable_collision_shape()

func desactivate_collisions(col_layer):
	var adjacent_tiles = [Vector2i(0,0), Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1), Vector2i(1,1), Vector2i(-1,1), Vector2i(-1,-1), Vector2i(1,-1)]
	for v in adjacent_tiles:
		if GameGlobal.render_layers.has(previous_iso_ground_loc + v):
			var old_col = GameGlobal.render_layers[previous_iso_ground_loc + v].column[col_layer-1]
			if not old_col.block == null:
				old_col.block.disable_collision_shape()
