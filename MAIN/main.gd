extends Node2D

const WORD_LENGTH = 4

@export var slots: Array[Node]

var current_word = ""

func _ready() -> void:
	for child in find_children("*", "Button"):
		if child.has_signal("letter_pressed"):
			child.letter_pressed.connect(_on_key_pressed)
			
func _on_key_pressed(letter):
	if letter == "BACK":
		#delete_letter()
		print("BACK")
	elif letter == "ENTER":
		#submit_word()
		print("ENTER")
	else:
		add_letter(letter)
	
func add_letter(letter):
	if current_word.length() < WORD_LENGTH:
		current_word += letter
		update_slots()

func update_slots():
	for i in range(WORD_LENGTH):
		if i < current_word.length():
			slots[i].set_letter(current_word[i])
		else :
			slots[i].set_empty()
