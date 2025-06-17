extends Node2D

@onready var player: CharacterBody3D = $"../../Player"

func _physics_process(_delta: float) -> void:
	rotation = 3.14 - player.rotation.y + 3.14*2.75
