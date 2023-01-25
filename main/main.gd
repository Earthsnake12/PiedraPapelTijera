extends Node

export(PackedScene) var elemento_scene
var enJuego = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func _process(delta):
	var CANT_PIEDRAS = get_tree().get_nodes_in_group("piedra").size() - 1
	var CANT_PAPELES = get_tree().get_nodes_in_group("papel").size() - 1
	var CANT_TIJERAS = get_tree().get_nodes_in_group("tijera").size() - 1
	
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
		
		if i < CANT: 
			elemento.setTipo("piedra")
		elif i < CANT * 2: 
			elemento.setTipo("papel")
		else: 
			elemento.setTipo("tijera")
			
		add_child(elemento)
	
	enJuego = true

