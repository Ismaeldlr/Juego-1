extends Area2D

var speed = 2750

func _physics_process(delta):
	position -= transform.y * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
