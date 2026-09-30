# Bulleye
extends Control

@export_enum("start","X","Y","waiting") var DIRECTION = 0
@export var button:Button

@onready var y: HBoxContainer = $"Arrow Manager/Y"
@onready var x: VBoxContainer = $"Arrow Manager/X"
@onready var bull: TextureRect = $bull

signal state(current_state:int)
signal level(value:int)

var center:Vector2 = Vector2.ZERO
var SPEED:int = 500
var tonggle:int = 1
var pos:Vector2 = Vector2.ZERO
var targer_pos:Vector2 = Vector2.ZERO
var reset_pos:Rect2 = Rect2(0,0,0,0)
var width:float = 25
var score:Array[int] = []

# Limits
# min => bulleye's position 
# max => position + 750 (img's size)

func _ready() -> void:
	if button:
		button.pressed.connect(_on_button_pressed)
	state.emit(DIRECTION)


func _process(delta: float) -> void:
	pos = $bull.position + $bull.size
	center = bull.position + (bull.size/2) * bull.scale
	
	match DIRECTION:
		0:
			$Crosshair.hide()
			reset_pos = Rect2(x.global_position,y.global_position)
		1:
			$Crosshair.hide()
			x.position.x += _loop_move(x.position.x + width,$bull.position.x + width,pos.x - width) * delta
		2:
			y.position.y += _loop_move(y.position.y + width,$bull.position.y + width,pos.y - width) * delta
		3:
			targer_pos = Vector2(x.position.x + width,y.position.y + width)
			$Crosshair.position = targer_pos - ($Crosshair.size/2)*$Crosshair.scale
			$Crosshair.show()
		_:
			pass


func _loop_move(current_pos:float,min_pos:float,max_pos:float) -> float:
	if current_pos >= max_pos:
		tonggle = -1
	elif current_pos <= min_pos:
		tonggle = 1
		
	return tonggle * SPEED


func _on_button_pressed() -> void:
	DIRECTION += 1
	if DIRECTION == 3:
		_get_accurency()
	elif DIRECTION > 3:
		x.global_position = reset_pos.position
		y.global_position = reset_pos.size
		DIRECTION = 1
		if $"..".game_over:
			GameManager.game_reset()
	state.emit(DIRECTION)


func _get_accurency():
	targer_pos = Vector2(x.position.x + width, y.position.y + width)
	
	var win:float = clamp(targer_pos.distance_to(center),0,250)
	level.emit(ceil(win / 50.0))
	score.append(ceil(win / 50.0))
