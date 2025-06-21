extends Area3D

@onready var wind_origin: Node3D = $"../WindOrigin"

#func _ready() -> void:
	#print("ready")
	##var timer = get_tree().create_timer(2)
	##await timer.timeout
	##wind_source_path = wind_origin.get_path()
	#print("New path!")
	

func _physics_process(_delta: float) -> void:
	set_wind_source_path(wind_origin.get_path())
	print(get_wind_source_path())
