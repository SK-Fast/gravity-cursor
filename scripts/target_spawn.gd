extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _spawn_timeout():
	if GameGlobal.is_game_over:
		return
	
	$SpawnTimer.start()
	$SpawnTimer.wait_time = GameGlobal.spawn_interval
	
	var new_target: Area2D = preload("res://scenes/target.tscn").instantiate()
	
	add_child(new_target)
