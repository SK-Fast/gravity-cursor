extends Node

func _on_spawn_timer_timeout():
	if GameGlobal.is_game_over:
		return
	
	$SpawnTimer.start()
	
	$SpawnTimer.wait_time = GameGlobal.spawn_interval + 1
	
	var new_target: RigidBody2D = preload("res://scenes/missile.tscn").instantiate()
	
	add_child(new_target)
