extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	#hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1		

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "upleft"
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "downleft"
		else:
			$AnimatedSprite2D.animation = "sideleft"
	elif Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "upright"
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "downright"
		else:
			$AnimatedSprite2D.animation = "sideright"

	elif velocity.y != 0:
		if velocity.y > 0: # up = false, down = true
			# true, so face infront for down
			$AnimatedSprite2D.animation = "front"
		else:
			# false, so face away for up ^
			$AnimatedSprite2D.animation = "back"
