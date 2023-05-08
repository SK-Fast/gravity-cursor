extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GameGlobal.connect("on_game_over", _on_game_over)
	GameGlobal.connect("on_game_start", _on_game_start)

func _on_game_over():
	$AnimPlay.play("dead")
	$ScoreReport.text = "Score: " + str(GameGlobal.score)
	$HighestScore.text = "Highest Score: " + str(GameGlobal.highest_score)

func _on_game_start():
	$AnimPlay.play("game_start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ScoreText.text = "Score: " + str(GameGlobal.score)
