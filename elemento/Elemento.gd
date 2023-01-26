extends Area2D

export var speed = 100 # Para manejar la velocidad desde afuera
signal tocado(elemento)
var tipo
var velocity

# Es llamado cuando se instancia el objeto
func _ready():
	randomize()
	
# es llamado en cada frame. Delta es el tiempo pasado entre frame
func _process(delta):

	var buscados
	
	if tipo == "piedra":
		buscados = get_node("/root/main/Control_Tijera").get_children()
	elif tipo == "papel":
		buscados = get_node("/root/main/Control_Piedra").get_children()
	elif tipo == "tijera":
		buscados = get_node("/root/main/Control_Papel").get_children()
		
	var objetivo = Vector2.ZERO
	for i in range(buscados.size()):
		
		if i == 0:
			objetivo = buscados[i].position - position
			
		elif objetivo.distance_to(buscados[i].position) < objetivo.length():
			objetivo = buscados[i].position - position

	velocity = objetivo.normalized() * speed
	
	position += velocity * delta
	

func setTipo(var eleccion_tipo):
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo

func _on_Elemento_area_entered(area):
	if ((tipo == "piedra" and area.tipo == "papel")
	or (tipo == "papel" and area.tipo == "tijera")
	or (tipo == "tijera" and area.tipo == "piedra")):
		emit_signal("tocado", self)
		$CollisionShape2D.set_deferred("disabled", true)
	

