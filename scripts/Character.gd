extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150
const JUMP_HEIGHT = -500
var motion = Vector2()
onready var animation_tree = get_node("AnimationTree")
var playback: AnimationNodeStateMachinePlayback
enum states {IDLE, MOVE, ATTACK, AIRBORNE, HURT}
var current_state

func _ready():
	playback = animation_tree.get("parameters/playback")
	playback.start("Jump")
	current_state = states.AIRBORNE

func _process(delta):
	# Check if animation returned to idle
	if playback.get_current_node() == "Idle" :
		current_state = states.IDLE
	
	match current_state:
		states.IDLE:
			if Input.is_action_just_pressed("hi_attack"):
				playback.travel("HighAttack")
				current_state = states.ATTACK
			if Input.is_action_just_pressed("mid_attack"):
				playback.travel("MidAttack")
				current_state = states.ATTACK
			if Input.is_action_just_pressed("low_attack"):
				playback.travel("LowAttack")
				current_state = states.ATTACK
			# TODO Remove this test code
			if Input.is_action_just_pressed("damage"):
				playback.travel("Damage")
				current_state = states.HURT
			if Input.is_action_pressed("move_left"):
				playback.travel("MoveBack")
				current_state = states.MOVE
			if Input.is_action_pressed("move_right"):
				playback.travel("MoveForward")
				current_state = states.MOVE
		states.MOVE:
#			if Input.is_action_just_pressed("hi_attack"):
#				playback.travel("HighAttack")
#				current_state = states.ATTACK
#			if Input.is_action_just_pressed("mid_attack"):
#				playback.travel("MidAttack")
#				current_state = states.ATTACK
#			if Input.is_action_just_pressed("low_attack"):
#				playback.travel("LowAttack")
#				current_state = states.ATTACK
			if Input.is_action_pressed("move_left"):
				playback.travel("MoveBack")
				# Already in MOVE state
			if Input.is_action_pressed("move_right"):
				playback.travel("MoveForward")
				# Already in MOVE state
			if Input.is_action_just_released("move_right"):
				playback.travel("Idle")
				current_state = states.IDLE
			if Input.is_action_just_released("move_left"):
				playback.travel("Idle")
				current_state = states.IDLE

func _physics_process(delta):
	match current_state:
		states.IDLE:
			if Input.is_action_just_pressed("jump"):
				motion.y = JUMP_HEIGHT
				current_state = states.AIRBORNE
				playback.travel("Jump")
		states.AIRBORNE:
			motion.y += GRAVITY
			if is_on_floor():
				playback.travel("Land")
				current_state = states.IDLE
		states.MOVE:
			if Input.is_action_pressed("move_right"):
				motion.x = SPEED
			elif Input.is_action_pressed("move_left"):
				motion.x = -SPEED
			else:
				motion.x = 0

	motion = move_and_slide(motion, UP)
