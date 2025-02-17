extends Camera2D

var target : Node2D  # Objetivo al que debe seguir la cámara

func _ready():
	target = get_node("/root/MainScene/CharacterBody2D")  # Nodo de la nave o jugador

func _process(delta):
	position = target.position  # Sigue la posición del jugador
