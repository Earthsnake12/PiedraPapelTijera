extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control_Start/Cantidad.text = "10"
	pass # Replace with function body.

func _process(delta):
	$Control_score/Piedras.text = ("Piedras: " + 
		str(get_tree().get_nodes_in_group("piedra").size() - 1))
	$Control_score/Papeles.text = ("Papeles: " + 
		str(get_tree().get_nodes_in_group("papel").size() - 1))
	$Control_score/Tijeras.text = ("Tijeras: " + 
		str(get_tree().get_nodes_in_group("tijera").size() - 1))

func start_game():
	var CANT = $Control_Start/Cantidad.text
	if CANT.is_valid_integer():
		$Control_score/Piedras.text = "Piedras: " + CANT
		$Control_score/Papeles.text = "Papeles: " + CANT
		$Control_score/Tijeras.text = "Tijeras: " + CANT
		
		$Control_score.show()
		$Control_Start.hide()
	else:
		$Control_Start/Error_ingreso.show()

	
func show_game_over():
	pass


func _on_Start_pressed():
	start_game()
	emit_signal("start_game")
