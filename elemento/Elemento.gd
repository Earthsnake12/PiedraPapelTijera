extends Area2D

export var speed = 100 # Para manejar la velocidad desde afuera
var screen_size #Tomo el tamaño de la pantalla
var velocity #Para guardar la velocidad
var tipo

# Es llamado cuando se instancia el objeto
func _ready():
	randomize()
	screen_size = get_viewport_rect().size #tomo el tamaño de la ventana
	
	#lo arranco en un punto random de la pantalla
	position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
	
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
		

func setTipo(var eleccion_tipo):
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo
	
func getTipo():
	return tipo
	

func _on_Elemento_area_entered(area):
	if ((tipo == "piedra" and area.getTipo() == "papel") 
	or (tipo == "papel" and area.getTipo() == "tijera") 
	or (tipo == "tijera" and area.getTipo() == "piedra")):
		queue_free()
	
