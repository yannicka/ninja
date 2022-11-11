extends Button

@export var level_number: int = 0

func _ready():
	get_node(".").text = str(level_number)

func _process(delta):
	pass
