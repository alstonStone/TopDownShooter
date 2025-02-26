extends CharacterBody2D

signal shoot
var can_shoot: bool

var speed:int
var screen_size:Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size/2
	speed = 200
	can_shoot = true

func get_input():
	var input_dir = Input.get_vector("left","right","up","down")
	velocity = input_dir.normalized() * speed
	#mouse clicks
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		can_shoot = false
		$ShotTimer.start()

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	var mouse_pos = get_local_mouse_position()
	var angle = snappedf(mouse_pos.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "walk"+str(angle)
	
	position = position.clamp(Vector2.ZERO,screen_size)
	if velocity.length() !=0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func _on_shot_timer_timeout() -> void:
	can_shoot = true
