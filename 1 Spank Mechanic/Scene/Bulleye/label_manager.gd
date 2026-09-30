# Label manager
extends VBoxContainer

@onready var label_up: Label = $"Label up"
@onready var label_down: Label = $"Label down"

const DIALOGUE_UP:String = "Spanking "
var character_name:String = "Evelyn "
var max_spank:int = 5
var cnt_spank:int = -1
var game_over:bool = false

var dialogue_down:Array[String] = [
	"Get ready to spank your boss",
	"Aim carfully at your boss butt",
	"Apply the right amoung of force"]
var cnt:int = -1

var dialogue_score:Array[String] = [
	"Perfect spank",
	"Good spank",
	"Passable spank",
	"Clumsy spank",
	"Failed spank"]

func _ready() -> void:
	$Bulleye2.state.connect(_update_down)
	$Bulleye2.state.connect(_update_up)
	_update_up(1)
	_update_down(0)


func _update_up(state:int):
	if state != 1:
		return
	
	cnt_spank += 1
	
	if cnt_spank > max_spank:
		print("Game Over")
		#cnt_spank = 0
		return
	
	label_up.text = DIALOGUE_UP + character_name + str(cnt_spank) + "/" + str(max_spank)

# 5 = 100
# 25 = 0
# 100 = -5 * prom + 125
func _update_down(_state:int):
	cnt += 1
	
	if cnt >= dialogue_down.size():
		cnt = 0
		label_down.text = dialogue_score[$Bulleye2.score[-1] - 1] 
		if cnt_spank >= max_spank:
			var prom:float = 0
			for i in $Bulleye2.score:
				prom += i
			label_down.text = "Final accurancy: " + str((-5 * prom) + 125) + "%"
			game_over = true
		return
	
	label_down.text = dialogue_down[cnt]
