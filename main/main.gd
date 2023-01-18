extends Node

export(PackedScene) var elemento_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in 30:
		var elemento = elemento_scene.instance()
		
		if i < 10: 
			elemento.setTipo("piedra")
		elif i < 20: 
			elemento.setTipo("papel")
		else: 
			elemento.setTipo("tijera")
			
		add_child(elemento)
		
	



