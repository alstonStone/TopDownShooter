extends CharacterBody2D

@onready var player = get_node("//root/Main/Player")

signal hit_player 

var alive : bool
var entered : bool
var speed : int = 100
var direction : Vector2


func _ready() -> void:
	alive = true
	var screen_rect = get_viewport_rect()
	entered = false
	var dist = screen_rect.get_center() - position
	
	if abs(dist.x) > abs(dist.y):
		direction.x = dist.x
		direction.y = 0
	else:
		direction.x = 0
		direction.y = dist.y

func _physics_process(delta: float) -> void:
	if alive:
		$AnimatedSprite2D.animation = "run"
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		pass

func die():
	alive = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "dead"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func _on_enterance_timer_timeout() -> void:
	entered = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()
