extends CharacterBody2D

@export var speed = 50  # Velocidad de movimiento
@export var Bullet : PackedScene  # La escena del proyectil del enemigo
@export var fire_rate = 1.0  # Tiempo entre disparos
var direction = 1  # 1 = Derecha, -1 = Izquierda
var health  # Salud inicial del boss
@export var health_bar: ProgressBar  # Barra de salud (asociada en el editor)

func _ready():
	# Configurar el temporizador para disparar automáticamente
	var timer = Timer.new()
	timer.wait_time = fire_rate
	timer.autostart = true
	timer.timeout.connect(_shoot)
	add_child(timer)
	
	# Configuramos la barra de salud (Asegúrate de tenerla configurada en el Editor)
	add_to_group("mobs")
	health = $"Health Bar".value

func take_damage(amount):
	health -= amount  # Reducir la salud
	health_bar.value = health  # Actualizar la barra de salud
	if health <= 0:
		queue_free()

#Se mueve de lado a lado
func _process(delta):
	position.x += speed * direction * delta  
	if position.x >= 200:  
		direction = -1 
	elif position.x <= -200:  
		direction = 1 

func _shoot():
	if Bullet:  # Asegurar que la escena del proyectil está asignada
		var b = Bullet.instantiate()
		get_tree().current_scene.add_child(b)
		b.position = global_position  # Se dispara desde la posición del enemigo
