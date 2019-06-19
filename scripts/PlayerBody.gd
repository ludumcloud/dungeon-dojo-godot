extends KinematicBody2D

var speed = 400
var velocity = Vector2()
onready var sprite = get_node("Pivot/Body")

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	
func get_input():
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	if Input.is_action_just_pressed("hi_attack"):
		sprite.play("attack")

	if velocity.x > 0:
		velocity.x -= 50
	if velocity.x < 0:
		velocity.x += 50


func _on_animation_finished():
	sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	move_and_collide(velocity * delta)
