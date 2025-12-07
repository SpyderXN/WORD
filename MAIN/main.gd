extends Node2D

const WORD_LENGTH = 4

@export var slots: Array[Node]
@onready var hint: Label = $UI/Hint
@onready var final_answer: Label = $UI/FinalAnswer
@onready var chances: Label = $UI/Tries

var current_word = ""
var can_input = true

func _ready() -> void:
	for child in find_children("*", "Button"):
		if child.has_signal("letter_pressed"):
			child.letter_pressed.connect(_on_key_pressed)
	start_level()

func start_level():
	GameManager.load_current_level()
	hint.text = "HINT: " + GameManager.get_current_hint()
	chances.text = "CHANCES: " + str(int(GameManager.chances_left))
	current_word = ""
	can_input = true
	clear_slots()

func submit_guess():
	var results = GameManager.check_guess(current_word)
	
	for i in range(WORD_LENGTH):
		slots[i].set_status(results[i])
	
	if GameManager.game_won(current_word):
		final_answer.text = "THATS CORRECT!"
		can_input = false
		await get_tree().create_timer(2.0).timeout
		GameManager.next_level()
		start_level() 
	else:
		# 4. DEDUCT CHANCE HERE (Only on a failed guess)
		GameManager.chances_left -= 1
		
		# 5. Check for loss after deduction
		if GameManager.chances_left <= 0:
			final_answer.text = "GAME OVER! Word was: " + GameManager.current_target_word
			can_input = false
			
		else:
			# Update UI immediately with the new, reduced chance count
			chances.text = "Try Again! Chances: " + str(int(GameManager.chances_left))
			current_word = ""
			await get_tree().create_timer(0.5).timeout
			clear_slot_text_only()


func clear_slots():
	for s in slots:
		s.set_empty()
		s.reset_color()

func clear_slot_text_only():
	for s in slots:
		s.set_letter("")
		s.reset_color()

func _on_key_pressed(letter):
	if letter == "BACK":
		#delete_letter()
		print("BACK")
	elif letter == "ENTER":
		if current_word.length() == WORD_LENGTH:
			submit_guess()
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
