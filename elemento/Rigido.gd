extends RigidBody2D

var screen_size #Tomo el tamaño de la pantalla
var tipo


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size #tomo el tamaño de la ventana
	
	#lo arranco en un punto random de la pantalla
	position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
	
func setTipo(var eleccion_tipo):
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo
	
func getTipo():
	return tipo
	
	

func _on_Rigido_body_entered(body):
	if ((tipo == "piedra" and body.getTipo() == "papel") 
	or (tipo == "papel" and body.getTipo() == "tijera") 
	or (tipo == "tijera" and body.getTipo() == "piedra")):
		queue_free()
