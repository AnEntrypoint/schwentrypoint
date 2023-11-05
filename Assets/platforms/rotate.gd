extends Node3D

func _physics_process(delta: float) -> void:
	rotate_y(2.0 * delta)
