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
		
func _process(delta):
	print("Piedras: " + str(get_tree().get_nodes_in_group("piedra").size()))
	print("Papeles: " + str(get_tree().get_nodes_in_group("papel").size()))
	print("Tijeras: " + str(get_tree().get_nodes_in_group("tijera").size()))
	print("------------------------------------------")
	

