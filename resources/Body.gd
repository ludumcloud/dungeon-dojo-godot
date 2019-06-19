extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		self.position.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		self.position.x += 1
