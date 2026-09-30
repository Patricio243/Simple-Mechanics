@tool
extends Control

func _ready() -> void:
	$Y/VSeparator.custom_minimum_size.x = $"../bull".size.x
	$X/VSeparator.custom_minimum_size.y = $"../bull".size.y
