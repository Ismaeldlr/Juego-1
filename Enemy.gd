extends CharacterBody2D

var speed = 50  # Velocidad de movimiento
@export var Bullet : PackedScene  # La escena del proyectil del enemigo
var fire_rate = randf_range(1,2)  # Tiempo entre disparos
var direction = 1  # 1 = Derecha, -1 = Izquierda
@export_flags_2d_physics var layers_2d_physics

func _ready():
	var timer = Timer.new()
	timer.wait_time = fire_rate
	timer.autostart = true
	timer.timeout.connect(_shoot)
	add_child(timer)
	
	add_to_group("mobs")
	collision_layer = 1    # Los enemigos están en la capa 1
	collision_mask = 2

func take_damage(amount):
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
