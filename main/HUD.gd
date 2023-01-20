extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control_Start/Cantidad.text = "10"
	pass # Replace with function body.

func start_game():
	var CANT = $Control_Start/Cantidad.text
	if CANT.is_valid_integer():
		$Control_score/Piedras.text = "Piedras: " + CANT
		$Control_score/Papeles.text = "Papeles: " + CANT
		$Control_score/Tijeras.text = "Tijeras: " + CANT
		
		$Control_game_over.hide()
		$Control_score.show()
		$Control_Start/Error_ingreso.hide()
		$Control_Start.hide()
	else:
		$Control_Start/Error_ingreso.show()

	
func show_game_over(ganador):
	$Control_score.hide()
	$Control_game_over/Ganador.text = "WIN " + ganador
	$Control_game_over.show()


func _on_Start_pressed():
	start_game()
	emit_signal("start_game")


