extends Node2D

@export var Enemy : PackedScene  # La escena del enemigo
@export var Boss : PackedScene  # La escena del Boss
@export var spawn_interval = 1  # Intervalo entre enemigos
@export var boss_delay = 10.0  # Tiempo después del cual aparece el Boss

var active_enemies = 0  # Contador de enemigos activos en pantalla

func _ready():
	# Iniciamos el spawn de los enemigos
	start_enemy_spawn()

# Función para empezar a spawnear enemigos
func start_enemy_spawn():
	# Iniciar el spawn de enemigos cada 'spawn_interval' segundos
	await get_tree().create_timer(spawn_interval).timeout  # Espera 2 segundos antes de comenzar
	spawn_enemy_at_random_position()  # Spawn el primer enemigo
	start_spawning_enemies()  # Inicia el bucle de enemigos periódicos

	# Esperar 10 segundos y luego spawn el Boss
	await get_tree().create_timer(boss_delay).timeout
	spawn_boss()

# Spawn enemigo en una posición aleatoria en los extremos de la pantalla
func spawn_enemy_at_random_position():
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	var positions = [
		Vector2(randf_range(-300, 200), -650),  # Arriba (fuera de la pantalla)
		Vector2(randf_range(-300, 200), -650)  # Abajo (fuera de la pantalla)
	]
	
	# Spawn del enemigo en una posición aleatoria
	var random_position = positions[randi() % positions.size()]
	spawn_enemy(random_position)

# Bucle para spawnear enemigos cada cierto intervalo
func start_spawning_enemies():
	while true:
		await get_tree().create_timer(spawn_interval).timeout  # Espera 'spawn_interval' segundos
		spawn_enemy_at_random_position()

# Generar un enemigo en una posición específica
func spawn_enemy(position: Vector2):
	if Enemy:
		var enemy = Enemy.instantiate()
		get_parent().add_child(enemy)  # Agregar enemigo a la escena principal
		enemy.position = position  # Asignar la posición personalizada
		active_enemies += 1  # Contamos el enemigo
		enemy.connect("tree_exited", Callable(self, "_on_enemy_defeated"))

# Función que maneja la muerte de un enemigo (se puede mejorar para gestión de rondas)
func _on_enemy_defeated():
	active_enemies -= 1
	print("Enemigo derrotado, enemigos restantes:", active_enemies)

# Generar el Boss después de 10 segundos
func spawn_boss():
	if Boss:
		var boss = Boss.instantiate()
		get_parent().add_child(boss)  # Agregar Boss a la escena principal
		boss.position = Vector2(0, -725)  # Posición de aparición del Boss
		print("¡El Boss ha aparecido!")
