extends CharacterBody2D

const SPEED = 80
@onready var block_held = $BlockHeld
@onready var state_manager = $StateManager
@onready var feet_position = $FeetPosition
@onready var ground_position = $GroundPosition
var climbing = false
var current_colission_layer = 1

func _ready():
	for i in range(0,16):
		layer_up(1)
	GameGlobal.player = self
	set_collision_layer_value(current_colission_layer, true)
	set_collision_mask_value(current_colission_layer, true)

func _physics_process(delta):
	var ground_iso = IsometricConverter._pos_to_iso(ground_position.global_position)
	var iso_loc = IsometricConverter.cursor_shift(IsometricConverter.vector_shift(ground_iso))
	if not climbing:
		if GameGlobal.render_layers.has(iso_loc):
			if GameGlobal.render_layers[iso_loc].top() < current_colission_layer-2:
				climbing = true
				layer_up(-1)
				$ClimbingTimer.start()
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

func _on_state_manager_player_climb(mouse_position):
	if not climbing:
		climbing = true
		layer_up(1)
		$ClimbingTimer.start()

func _on_climbing_timer_timeout():
	climbing = false

func iso_pos():
	var ground_iso = IsometricConverter._pos_to_iso(ground_position.global_position)
	return ground_iso
