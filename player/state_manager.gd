extends Node2D

const STATE_IDLE = preload("res://player/state_idle.tscn")
const STATE_WALKING = preload("res://player/state_walking.tscn")
const STATE_LIFTING = preload("res://player/state_lifting.tscn")
const STATE_LIFT_WALKING = preload("res://player/state_lift_walking.tscn")

const states = {
	"idle":STATE_IDLE,
	"walk":STATE_WALKING,
	"lift":STATE_LIFTING,
	"lift_walking":STATE_LIFT_WALKING
}

var animations
var current_state
signal change_velocity(vector2)
signal player_lift(mouse_position)
signal player_climb(mouse_position)

func _ready():
	animations = get_node("../AnimatedSprite2D")
	current_state = states["idle"].instantiate()
	current_state.state_manager = self
	add_child(current_state)

func _process(delta):
	if Input.is_action_just_pressed("climb"):
		manage_climb(get_global_mouse_position())

func change_state(state, last_direction):
	current_state.queue_free()
	current_state = states[state].instantiate()
	current_state.state_manager = self
	current_state.last_direction = last_direction
	add_child(current_state)

func update_velocity(vector2):
	emit_signal("change_velocity", vector2)

func manage_lift(mouse_position):
	emit_signal("player_lift", mouse_position)

func manage_climb(mouse_position):
	emit_signal("player_climb", mouse_position)
