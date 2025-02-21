extends Node2D

@onready var main = get_node("//root/Main")

signal hit_p

var goblin_scene := preload("res://Scenes/goblin.tscn")
var spawn_points := []


func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)




func _on_timer_timeout() -> void:
	var spawn = spawn_points.pick_random()
	var goblin = goblin_scene.instantiate()
	goblin.position = spawn.position
	goblin.hit_player.connect(hit)
	main.add_child(goblin)

func hit():
	hit_p.emit()
