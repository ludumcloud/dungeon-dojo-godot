extends AnimationTree

var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = get("parameters/playback")
	playback.start("Idle")
	active = true
	
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