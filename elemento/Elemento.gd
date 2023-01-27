extends Area2D

export var speed = 100 # Para manejar la velocidad desde afuera
signal tocado(elemento)
var tipo

# Es llamado cuando se instancia el objeto
func _ready():
	randomize()
	
# es llamado en cada frame. Delta es el tiempo pasado entre frame
func _process(delta):

	var objetivos
	match tipo:
		"piedra":
			objetivos = get_node("/root/main/Control_Tijera").get_children()
		"papel":
			objetivos = get_node("/root/main/Control_Piedra").get_children()
		"tijera":
			objetivos = get_node("/root/main/Control_Papel").get_children()
		
	if objetivos.size() == 0:
		return
		
	var dist_objetivo = objetivos[0].position - position
	for i in range(1, objetivos.size()):
		
		var prueba =  objetivos[i].position - position
		if prueba.length() < dist_objetivo.length():
			
			dist_objetivo = prueba

	var velocity = dist_objetivo.normalized() * speed
	
	position += velocity * delta
	

func setTipo(var eleccion_tipo):
	tipo = eleccion_tipo
	$AnimatedSprite.animation = tipo

func _on_Elemento_area_entered(area):
	if ((tipo == "piedra" and area.tipo == "papel")
	or (tipo == "papel" and area.tipo == "tijera")
	or (tipo == "tijera" and area.tipo == "piedra")):
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("tocado", self)
	

