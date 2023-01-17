extends Area2D

export var speed = 1 # Para manejar la velocidad desde afuera
var screen_size #Tomo el tamaño de la pantalla
var velocity #Para guardar la velocidad

# Es llamado cuando se instancia el objeto
func _ready():
	screen_size = get_viewport_rect().size #tomo el tamaño de la ventana
	
	#creo el vector velocidad
	velocity = Vector2(rand_range(0, 1), rand_range(0, 1))
	velocity = velocity.normalized() * speed
	

# es llamado en cada frame. Delta es el tiempo pasado entre frame
func _process(delta):
		
	position += velocity * delta
	if position.x < 0 or position.x >  screen_size.x:
		velocity.x *= -1
		position.x += velocity.x * delta
		
	if position.y < 0 or position.y >  screen_size.y:
		velocity.y *= -1
		position.y += velocity.y * delta
	

