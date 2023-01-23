extends Area2D

export var speed = 100 # Para manejar la velocidad desde afuera
var screen_size #Tomo el tamaño de la pantalla
var tipo

# Es llamado cuando se instancia el objeto
func _ready():
	randomize()
	screen_size = get_viewport_rect().size #tomo el tamaño de la ventana

	position = Vector2(rand_range(10, screen_size.x-10), rand_range(10, screen_size.y-10))


# es llamado en cada frame. Delta es el tiempo pasado entre frame
func _process(delta):
	
	var velocity = Vector2.ZERO

	var buscados
	if tipo == "piedra":
		buscados = get_tree().get_nodes_in_group("tijera")
	elif tipo == "papel":
		buscados = get_tree().get_nodes_in_group("piedra")
	elif tipo == "tijera":
		buscados = get_tree().get_nodes_in_group("papel")
		
	
	for i in range(1, buscados.size()):
		if position.distance_to(buscados[i].position) > velocity.length():
			velocity = buscados[i].position-position
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	

func setTipo(var eleccion_tipo):
	if(tipo != null):
		remove_from_group(tipo)
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo
	add_to_group(eleccion_tipo)
	

func _on_Elemento_area_entered(area):
	if ((tipo == "piedra" and area.tipo == "papel") 
	or (tipo == "papel" and area.tipo == "tijera") 
	or (tipo == "tijera" and area.tipo == "piedra")):
		setTipo(area.tipo)
	
