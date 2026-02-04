extends Area2D

func _ready():
	# Connect the body_entered signal to our own handler
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if the body that entered is the Player
	if body.is_in_group("player") or body.name == "Player":
		# Call the player's collect_coin method
		if body.has_method("collect_coin"):
			body.collect_coin(self)
