extends CharacterBody2D

var iso_pos
var collision
var tag

func on_creation(): pass

func on_born(): pass
func player_unlift_action(iso_mouse): pass

func play_animation(animation):
	var anim = $AnimatedSprite2D
	anim.animation = animation
	anim.play()

func drop():pass

func set_collisions(layer):
	collision = layer + 1
	set_collision_layer_value(collision, true)

func disable_collisions():
	set_collision_layer_value(collision, false)

func disable_collision_shape():
	get_node("CollisionPolygon2D").disabled = true
	get_node("CollisionPolygon2D").hide()

func enable_collision_shape():
	get_node("CollisionPolygon2D").disabled = false
	get_node("CollisionPolygon2D").show()

#UNLIFT
func unlift_empty(): pass
func unlift_default(): pass
func unlift_water(): pass

#ON_BORN
func born_default(born_iso_pos): pass
func born_empty(born_iso_pos): pass
func born_water(born_iso_pos): pass
