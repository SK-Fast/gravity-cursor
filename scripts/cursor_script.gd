extends CharacterBody2D

var targets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("is_player", true)
	$Area2D.set_meta("is_player", true)
	
	GameGlobal.connect("on_game_over", game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	remove_child($Cursor)
	remove_child($Area2D)

func _on_area_2d_area_entered(area: Area2D):
	print(area)
	if area.get_meta("is_target"):
		targets.push_front(area)
	if area.get_meta("is_missile"):
		if area.get_meta("is_hitted"):
				return
			
		GameGlobal.game_over()
		game_over()


func _on_area_2d_area_exited(area):
	if area.get_meta("is_target"):
		targets.remove_at(targets.bsearch(area))

func _input(event):
	if event.is_action_pressed("fire"):
		$AnimPlay.play("shoot")
		$ShootSound.play()
		for t in targets:
			if t.get_meta("is_hitted"):
				continue
			
			t.got_hitted()
			GameGlobal.add_score()
