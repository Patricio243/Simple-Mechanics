# Visuals
extends TextureRect

const EVELYN_DESK_SPANK_HIT = preload("uid://beejq3ub468uw")
const EVELYN_DESK_SPANK_AIM = preload("uid://fhw1tbqkxxmc")

func _ready() -> void:
	$"../ColorRect/MarginContainer/VBoxContainer/Bulleye2".state.connect(_update_visual)

func _update_visual(state:int):
	match state:
		3:
			self.texture = EVELYN_DESK_SPANK_HIT
			$"../../Moans".pitch_scale = randf_range(0.8,1.2)
			$"../../Moans".play()
		_:
			self.texture = EVELYN_DESK_SPANK_AIM
