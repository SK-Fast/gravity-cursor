extends Area2D


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("is_target", true)
	
	scale = Vector2(0,0)
	$AnimPlay.play("pop")
	
	var screen_size = get_viewport().size
	
	position.x = rng.randf_range(0, screen_size.x)
	position.y = rng.randf_range(0, screen_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func got_hitted():
	set_meta("is_hitted", true)
	
	$Audio.play()
	
	remove_child($Sprite)
	
	$Particle.emitting = true
	
	await get_tree().create_timer(0.5).timeout
	
	get_parent().remove_child(self)
