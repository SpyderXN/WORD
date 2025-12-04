extends Button


signal letter_pressed(letter)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_self_pressed)


func _on_self_pressed():
	letter_pressed.emit(text)

func setup(character: String):
	text = character
