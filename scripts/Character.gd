extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150
const JUMP_HEIGHT = -500
var motion = Vector2()
onready var animation_tree = get_node("AnimationTree")
var playback: AnimationNodeStateMachinePlayback


func _ready():
	playback = animation_tree.get("parameters/playback")
	playback.start("Idle")

func _process(delta):
	if Input.is_action_just_pressed("hi_attack"):
		playback.travel("HighAttack")
	if Input.is_action_just_pressed("mid_attack"):
		playback.travel("MidAttack")
	if Input.is_action_just_pressed("low_attack"):
		playback.travel("LowAttack")
	if Input.is_action_just_released("jump"):
		playback.travel("Jump")
	if Input.is_action_just_pressed("damage"):
		playback.travel("Damage")
	if Input.is_action_pressed("move_left"):
		playback.travel("MoveBack")
	if Input.is_action_pressed("move_right"):
		playback.travel("MoveForward")
	if Input.is_action_just_released("move_right"):
		playback.travel("Idle")
	if Input.is_action_just_released("move_left"):
		playback.travel("Idle")

func _physics_process(delta):
	motion.y += GRAVITY

	if Input.is_action_pressed("move_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("move_left"):
		motion.x = -SPEED
	else:
		motion.x = 0

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT

	motion = move_and_slide(motion, UP)
