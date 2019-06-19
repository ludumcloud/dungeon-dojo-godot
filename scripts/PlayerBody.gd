extends KinematicBody2D

var speed = 400
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func get_input():
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	if velocity.x > 0:
		velocity.x -= 50
	if velocity.x < 0:
		velocity.x += 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	move_and_collide(velocity * delta)
