extends Area2D

export var speed = 100 # Para manejar la velocidad desde afuera
var tipo

# Es llamado cuando se instancia el objeto
func _ready():
	randomize()
	
# es llamado en cada frame. Delta es el tiempo pasado entre frame
func _process(delta):

	var objetivos
	var evitar
	
	match tipo:
		"piedra":
			objetivos = get_node("/root/main/Control_Tijera").get_children()
			evitar = get_node("/root/main/Control_Papel").get_children()
			
		"papel":
			objetivos = get_node("/root/main/Control_Piedra").get_children()
			evitar = get_node("/root/main/Control_Tijera").get_children()
			
		"tijera":
			objetivos = get_node("/root/main/Control_Papel").get_children()
			evitar = get_node("/root/main/Control_Piedra").get_children()
		
	if objetivos.size() == 0:
		return
		
	var dist_objetivo = objetivos[0].position - position
	for i in range(1, objetivos.size()):
		
		var prueba =  objetivos[i].position - position
		if prueba.length() < dist_objetivo.length():
			
			dist_objetivo = prueba
	
	var dist_evitar
	if evitar.size() == 0:
		dist_evitar = Vector2.ZERO
	else:		
		dist_evitar= evitar[0].position - position
		for i in range(1, evitar.size()):
		
			var prueba =  evitar[i].position - position
			if prueba.length() < dist_evitar.length():
			
				dist_evitar = prueba
		dist_evitar.rotated(PI/2)

	if (dist_evitar.length() > speed):
		dist_evitar = Vector2.ZERO
		
	var velocity = (dist_objetivo.normalized() + dist_evitar.normalized() * -0.7)* speed
	
	position += velocity * delta
	

func setTipo(var eleccion_tipo):
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo

func _on_Elemento_area_entered(area):
	if ((tipo == "piedra" and area.tipo == "papel")
	or (tipo == "papel" and area.tipo == "tijera")
	or (tipo == "tijera" and area.tipo == "piedra")):
		queue_free()
		
