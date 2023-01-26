extends Node

export(PackedScene) var elemento_scene
var screen_size
var enJuego = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport().size #tomo el tamaño de la ventana
	
func _process(delta):
	var CANT_PIEDRAS = $Control_Piedra.get_child_count()
	var CANT_PAPELES = $Control_Papel.get_child_count()
	var CANT_TIJERAS = $Control_Tijera.get_child_count()
	
	$HUD/Control_score/Piedras.text = "Piedras: " + str(CANT_PIEDRAS)
	$HUD/Control_score/Papeles.text = "Papeles: " + str(CANT_PAPELES)
	$HUD/Control_score/Tijeras.text = "Tijeras: " + str(CANT_TIJERAS)
	
	if enJuego and (CANT_PIEDRAS == 0 or CANT_PAPELES == 0 or CANT_TIJERAS == 0):
		
		if CANT_PIEDRAS == 0:
			$HUD.show_game_over("TIJERAS")
		if CANT_PAPELES == 0:
			$HUD.show_game_over("PIEDRAS")
		if CANT_TIJERAS == 0:
			$HUD.show_game_over("PAPELES")
			
		enJuego = false

func _on_HUD_start_game():
	get_tree().call_group("elementos", "queue_free")
	
	var CANT = int($HUD/Control_Start/Cantidad.text)
		
	for i in CANT*3:
		var elemento = elemento_scene.instance()
		elemento.position = Vector2(rand_range(10, screen_size.x-10), rand_range(10, screen_size.y-10))
		
		if i < CANT: 
			elemento.setTipo("piedra")
			$Control_Piedra.add_child(elemento)
		elif i < CANT * 2: 
			elemento.setTipo("papel")
			$Control_Papel.add_child(elemento)
		else: 
			elemento.setTipo("tijera")
			$Control_Tijera.add_child(elemento)
			
		elemento.connect("tocado", self, "_on_Elemento_tocado")
	
	enJuego = true

func _on_Elemento_tocado(elemento):
	var pos = elemento.position
	var viejoTipo = elemento.tipo
	elemento.queue_free()
	
	var nuevoElemento = elemento_scene.instance()
	nuevoElemento.position = pos
	
	match viejoTipo:
		"piedra":
			nuevoElemento.setTipo("papel")
			$Control_Papel.call_deferred("add_child", nuevoElemento)
		"papel":
			nuevoElemento.setTipo("tijera")
			$Control_Tijera.call_deferred("add_child", nuevoElemento)
		"tijera":
			nuevoElemento.setTipo("piedra")
			$Control_Piedra.call_deferred("add_child", nuevoElemento)
	
	nuevoElemento.connect("tocado", self, "_on_Elemento_tocado")
