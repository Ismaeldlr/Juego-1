extends CharacterBody2D

var speed = 500
var direction = Vector2(0, 1)  # Dispara hacia abajo

func _ready():
	add_to_group("enemy_bullets")  # Añadir la bala al grupo de balas del jugador
	collision_layer = 2
	collision_mask = 1

func _physics_process(delta):
	# Mover la bala
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)  # Detecta la colisión en el movimiento

	if collision != null:  # Si hay colisión, procesarla
		var body = collision.get_collider()
		if body and body.is_in_group("player"):  # Si la bala choca con un enemigo (mobs)
			body.take_damage(1)  # Llamar al método de daño del enemigo
			queue_free()  # Destruir la bala
		
		if body and body.is_in_group("player_bullets"):  # Si la bala choca con un enemigo (mobs)
			queue_free()  # Destruir la bala
			body.queue_free()

func set_direction(dir: Vector2):
	direction = dir.normalized()
