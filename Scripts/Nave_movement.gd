extends CharacterBody2D

@export var Bullet : PackedScene
@export var speed = 400
@export var horizontal_speed = 1.2  # Velocidad específica para la dirección izquierda/derecha
@onready var enemy_spawner = $"../EnemySpawner"  # Asegúrate de que la ruta es correcta
var health  # Salud inicial del boss
@export var health_bar: ProgressBar  # Barra de salud (asociada en el editor)

func _ready():
	add_to_group("player")  # Añadir la bala al grupo de balas del jugador
	health = $"Health Bar".value

func take_damage(amount):
	health -= amount  # Reducir la salud
	health_bar.value = health  # Actualizar la barra de salud
	if health <= 0:
		queue_free()

func _process(delta):
	if Input.is_action_just_pressed("start_round"):
		enemy_spawner.start_round()  # Inicia la siguiente ronda

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

	# Restringir los límites de la nave
	limit_position()

func limit_position():
	var screen_rect = get_viewport_rect()  # Obtiene el área visible del juego
	
	# Definir los límites para la nave
	var min_x = screen_rect.position.x - 220  # Límite izquierdo con margen
	var max_x = screen_rect.end.x - 280       # Límite derecho con margen
	var min_y = screen_rect.position.y - 1030  # Límite superior con margen
	var max_y = screen_rect.end.y - 1000       # Límite inferior con margen

	# Aplicar restricciones
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)

func shoot():
	var b = Bullet.instantiate()
	get_parent().add_child(b)
	
	# Colocamos el proyectil en la posición de la nave al momento del disparo
	b.position = global_position  # Usar global_position en lugar de position
