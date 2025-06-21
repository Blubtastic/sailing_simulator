extends Area3D

@onready var wind_origin: Node3D = $"../WindOrigin"
@onready var node_2: Node3D = $Node2

#func _ready() -> void:
	#print("ready")
	##var timer = get_tree().create_timer(2)
	##await timer.timeout
	##wind_source_path = wind_origin.get_path()
	#print("New path!")
	

#func _physics_process(_delta: float) -> void:
	#set_wind_source_path(node_2.get_path())

#func _physics_process(_delta: float) -> void:
	#transform.basis.y = Vector3(0,1,0)
