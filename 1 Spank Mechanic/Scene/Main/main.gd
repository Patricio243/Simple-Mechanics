#Main
extends Control

@export var debug:bool = false
@export var label:Label

@onready var visual: TextureRect = $Visual
@onready var label_manager: VBoxContainer = $HBoxContainer/ColorRect/MarginContainer/VBoxContainer
@onready var bulleye: Control = $HBoxContainer/ColorRect/MarginContainer/VBoxContainer/Bulleye2


func _process(_delta: float) -> void:
	if debug:
		_track_mouse_pos()
		queue_redraw()


func _draw() -> void:
	draw_line(bulleye.x.position + Vector2(bulleye.width,0),Vector2(bulleye.x.position.x + bulleye.width,1080),Color.BLUE,5)
	draw_line(bulleye.y.position + Vector2(0,bulleye.width),Vector2(1920,bulleye.y.position.y + bulleye.width),Color.RED,5)
	draw_circle(bulleye.targer_pos,4,Color.WHITE)
	
	#draw_circle((bulleye.bull.position + bulleye.bull.size/2),250,Color.WHITE)
	#draw_circle((bulleye.bull.position + bulleye.bull.size/2),200,Color.BLACK)
	#draw_circle((bulleye.bull.position + bulleye.bull.size/2),150,Color.LIGHT_BLUE)
	#draw_circle((bulleye.bull.position + bulleye.bull.size/2),100,Color.DARK_RED)
	#draw_circle((bulleye.bull.position + bulleye.bull.size/2),50,Color.YELLOW)
	
	draw_line(bulleye.center,bulleye.targer_pos,Color.DEEP_PINK,5)


func _track_mouse_pos():
	label.position = get_local_mouse_position() + Vector2(10,0)
	var distance:float = label.position.distance_to(bulleye.center)
	label.text = str(distance)
