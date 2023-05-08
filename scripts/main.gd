extends Node

@export var gravity = 4000

var screen_size: Vector2i

func draw_collision_line(from: Vector2, to: Vector2):
	var cshape = CollisionShape2D.new()
	var line = SegmentShape2D.new()
	
	line.a = from
	line.b = to
	
	cshape.shape = line
	
	$Body2D.add_child(cshape)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	
	#draw_collision_line(Vector2(0,0), Vector2(screen_size.x,0))
	draw_collision_line(Vector2(screen_size.x,0), Vector2(screen_size.x,screen_size.y))
	draw_collision_line(Vector2(screen_size.x,screen_size.y), Vector2(0,screen_size.y))
	draw_collision_line(Vector2(0,screen_size.y), Vector2(0,0))

var oldMousePos = Vector2i(0, 0)

var mouse_on_ground = true
var first_time_fling = true
var flinging = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node_or_null("Cursor") == null:
		return
	
	var _velocity: Vector2 = $Cursor.velocity
	var mousepos = DisplayServer.mouse_get_position()

	if $Cursor.is_on_floor():
		mouse_on_ground = true
	else:
		mouse_on_ground = false
	
	_velocity.y += gravity * delta
	
	_velocity = _velocity.lerp(Vector2(0, _velocity.y), delta * 2.7)
	
	$Cursor.velocity = _velocity
	$Cursor.move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		if get_node_or_null("Cursor") == null:
			return
		
		if $Cursor.position.y > 500:
			flinging = true
			
		if $Cursor.position.y < 500:
			if flinging == true:
				$JumpSound.play()
			flinging = false
			if first_time_fling:
				first_time_fling = false
				GameGlobal.first_fling()
			return
		
		var vY = event.relative.y * 2.5
		
		$Cursor.velocity += Vector2(event.relative.x * 2.5, vY)


func _on_diff_time_timeout():
	if GameGlobal.spawn_interval < 1:
		return
	
	$DiffTime.start()
	
	GameGlobal.spawn_interval -= 0.1
