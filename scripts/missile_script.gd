extends RigidBody2D

var rng = RandomNumberGenerator.new()
var is_hitted = false

@onready var the_parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("is_missile", true)
	
	$Area2D.set_meta("is_missile", true)
	
	var screen_size = get_viewport().size
	
	position.x = rng.randf_range(0, screen_size.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_meta("is_missile"):
		return
	
	if is_hitted:
		return
	
	is_hitted = true
	
	$Audio.play()
	$Area2D.set_meta("is_hitted", true)
	
	if body.get_meta("is_player"):
		GameGlobal.game_over()
		
	remove_child($Sprite)
	remove_child($CollisionShape2D)
	remove_child($CPUParticles2D)
	remove_child($Area2D)
	
	$ExplodeParticle.emitting = true
	
	if get_tree():
		await get_tree().create_timer(1).timeout
	
	if the_parent:
		the_parent.remove_child(self)
