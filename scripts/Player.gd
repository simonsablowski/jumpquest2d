extends CharacterBody2D

@export var speed := 200
@export var jump_force := 400
@export var gravity := 800

func _physics_process(delta):
	velocity.y += gravity * delta

	var direction := 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1

	velocity.x = direction * speed

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force

	move_and_slide()
