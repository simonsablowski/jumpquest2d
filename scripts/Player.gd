extends CharacterBody2D

@export var speed := 200
@export var jump_force := 400
@export var gravity := 800

var score := 0

@onready var animated_sprite := $AnimatedSprite2D

func _ready():
	# Add player to "player" group for easy identification
	add_to_group("player")

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
	
	update_animation(direction)

func update_animation(direction):
	if direction != 0:
		animated_sprite.flip_h = direction < 0
	
	if not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func collect_coin(coin):
	score += 1
	update_score_label()
	coin.queue_free()

func update_score_label():
	get_node("../UI/ScoreLabel").text = "Score: %d" % score
