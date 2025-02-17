extends CharacterBody2D

@export var Bullet : PackedScene
@export var speed = 1000
@export var horizontal_speed = 1.2  # Velocidad específica para la dirección izquierda/derecha

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Modificar la velocidad horizontal
	input_direction.x *= horizontal_speed
	
	# Aplicar la velocidad al personaje
	velocity = input_direction * speed
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func _physics_process(delta):
	get_input()
	move_and_slide()

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
