extends Node2D

var collision
var tag
var unlift_function

func color_gradient():
	var white = Color(1, 1, 1, 1)
	var dark = ((8-float(collision)) / 8.0) / 1.1
	$AnimatedSprite2D.self_modulate = white.darkened(dark)

func play_animation(animation):
	var anim = $AnimatedSprite2D
	anim.animation = animation
	anim.play()

func set_collisions(layer):
	collision = layer + 1
	get_node("StaticBody2D").set_collision_layer_value(collision, true)

func disable_collisions():
	get_node("StaticBody2D").set_collision_layer_value(collision, false)

func enable_collision_shape():
	get_node("StaticBody2D/CollisionPolygon2D").disabled = false
	get_node("StaticBody2D/CollisionPolygon2D").show()

func disable_collision_shape():
	get_node("StaticBody2D/CollisionPolygon2D").disabled = true
	get_node("StaticBody2D/CollisionPolygon2D").hide()
