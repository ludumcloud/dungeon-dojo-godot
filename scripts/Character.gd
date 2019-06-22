extends KinematicBody2D

var speed = 400
var velocity = Vector2()

const IDLE = 'Idle'
const HIGH_ATTACK = 'HighAttack'

onready var animation_player = get_node("AnimationPlayer")

# Signal Handlers
func _on_animation_finished(animation):
	if (animation == IDLE):
		return
	else:
		animation_player.play(IDLE)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play(IDLE)
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	
func get_input():
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		
	if Input.is_action_just_pressed("hi_attack"):
		animation_player.play(HIGH_ATTACK)

	if velocity.x > 0:
		velocity.x -= 50
	if velocity.x < 0:
		velocity.x += 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	move_and_collide(velocity * delta)
