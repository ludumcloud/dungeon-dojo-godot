extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150
const JUMP_HEIGHT = -500
var motion = Vector2()
onready var animation_tree = get_node("AnimationTree")
onready var audio_playback = get_node("AudioStreamPlayer")
var playback: AnimationNodeStateMachinePlayback
var last_input = ""
var last_input_dt = 0.0

func _ready():
	playback = animation_tree.get("parameters/playback")
	playback.start("Idle")

func _input(event):
	last_input_dt = 0.100
	if event.is_action_pressed("hi_attack"):
		last_input = "HighAttack"
	elif event.is_action_pressed("mid_attack"):
		last_input = "MidAttack"
	elif event.is_action_pressed("low_attack"):
		last_input = "LowAttack"
	elif event.is_action_pressed("jump"):
		last_input = "Jump"
	elif event.is_action_pressed("damage"):
		last_input = "Damage"

func _process(delta):
	if playback.get_current_node() == "Idle" && last_input != "":
		playback.travel(last_input)
		last_input = ""
	elif is_on_floor():
		if Input.is_action_pressed("move_left"):
			playback.travel("MoveBack")
		elif Input.is_action_pressed("move_right"):
			playback.travel("MoveForward")
		elif Input.is_action_just_released("move_right"):
			playback.travel("Idle")
		elif Input.is_action_just_released("move_left"):
			playback.travel("Idle")
	last_input_dt -= delta
	if last_input_dt <= 0:
		last_input_dt = 0
		last_input = ""

func _physics_process(delta):
	var current_state = playback.get_current_node()

	motion.y += GRAVITY

	if current_state == "MoveForward":
		motion.x = SPEED
	elif current_state == "MoveBack":
		motion.x = -SPEED
	else:
		motion.x = 0

	if is_on_floor():
		if current_state == "Fall":
			playback.travel("Land")
		if current_state == "Jump":
			motion.y = JUMP_HEIGHT

	motion = move_and_slide(motion, UP)
