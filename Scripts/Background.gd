extends ParallaxLayer

@export var speed: float = 50  # Velocidad del fondo

func _process(delta):
	motion_offset.y += speed * delta  # Mueve el fondo hacia abajo
