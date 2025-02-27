extends Node

var wave : int
var max_enemies : int
var lives : int

func _ready() -> void:
	max_enemies = 10
	wave = 1
	lives = 3
	$HUD/LivesLabel.text = "X "+str(lives)
	$HUD/WaveLabel.text = "WAVE: "+str(wave)
	$HUD/EnemiesLabel.text = "X "+str(max_enemies)

func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	$HUD/LivesLabel.text = "X "+str(lives)
	pass
	
