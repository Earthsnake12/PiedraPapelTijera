extends Node

export(PackedScene) var elemento_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	

func _on_HUD_start_game():
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
