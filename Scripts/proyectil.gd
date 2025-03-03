extends CharacterBody2D

var speed = 1050
var direction = Vector2(0, -1)  # Dirección de movimiento (hacia la derecha, por ejemplo)

func _ready():
	add_to_group("player_bullets")  # Añadir la bala al grupo de balas del jugador

func _physics_process(delta):
	# Mover la bala
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)  # Detecta la colisión en el movimiento

	if collision != null:  # Si hay colisión, procesarla
		var body = collision.get_collider()
		if body and body.is_in_group("mobs"):  # Si la bala choca con un enemigo (mobs)
			body.take_damage(1)  # Llamar al método de daño del enemigo
			queue_free()  # Destruir la bala
