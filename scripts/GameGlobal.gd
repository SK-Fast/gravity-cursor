extends Node

signal on_game_over
signal on_game_start

var is_game_over = true
var is_game_started = false
var score = 0
var highest_score = 0
var spawn_interval = 4

@onready var latest_scene = get_node("/root/CursorBox")

var highest_score_path = "user://gravity_save.forreal"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if FileAccess.file_exists(highest_score_path):
		var latest_highscore = FileAccess.get_file_as_string(highest_score_path)
		
		highest_score = int(latest_highscore)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_score():
	score += 1

func game_over():
	print("Dead")
	
	if score > highest_score:
		highest_score = score
		
		var highscore_save = FileAccess.open(highest_score_path, FileAccess.WRITE)
		highscore_save.store_line(str(score))
	
	on_game_over.emit()
	is_game_over = true

func first_fling():
	print("Game Start")
	is_game_over = false
	is_game_started = true
	on_game_start.emit()

func _input(event):
	if event.is_action_pressed("fire"):
		if is_game_started and is_game_over:
			
			if latest_scene:
				latest_scene.get_tree().paused = true
				
				remove_child(latest_scene)
			
				latest_scene.call_deferred("free")
			
			var new_scene = preload("res://cursor_box.tscn").instantiate()

			get_parent().add_child(new_scene)
			
			new_scene.get_tree().paused = false
			
			latest_scene = new_scene
			
			score = 0
			is_game_started = false
			is_game_over = true

