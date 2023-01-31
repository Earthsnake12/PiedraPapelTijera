extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control_Start/Cantidad.text = "10"

func show_game_over(ganador):
	#$Control_score.hide()
	$Control_game_over/Ganador.text = "WIN " + ganador
	$Control_game_over.show()

func _on_Start_pressed():
	var CANT = $Control_Start/Cantidad.text
	
	$Control_score/Piedras.text = "Piedras: " + CANT
	$Control_score/Papeles.text = "Papeles: " + CANT
	$Control_score/Tijeras.text = "Tijeras: " + CANT
		
	$Control_game_over.hide()
	$Control_Start.hide()
	$Control_score.show()

	emit_signal("start_game")

func _on_Aumentar_button_down():
	var CANT = int($Control_Start/Cantidad.text)
	if CANT < 30:
		CANT += 1
		$Control_Start/Cantidad.text = str(CANT)

func _on_Disminuir_button_down():
	var CANT = int($Control_Start/Cantidad.text)
	if CANT > 1:
		CANT -= 1
		$Control_Start/Cantidad.text = str(CANT)
		
func _on_main_menu_pressed():
	$Control_game_over.hide()
	$Control_score.hide()
	$Control_Start.show()
