extends Node2D

# --- DATA ---
var levels = [
	{"word": "GAME", "hint": "You are playing one right now"},
	{"word": "CODE", "hint": "Written instructions for computers"},
	{"word": "TREE", "hint": "Has leaves and a trunk"},
	{"word": "LION", "hint": "King of the jungle"},
	{"word": "BLUE", "hint": "Color of the sky"},
	{"word": "FIRE", "hint": "Hot and burns"},
	{"word": "SNOW", "hint": "Cold white rain"},
	{"word": "BIRD", "hint": "Has wings and flies"},
	{"word": "FISH", "hint": "Swims in water"},
	{"word": "STAR", "hint": "Shines in the night sky"}
]

var current_level = 0
var chances_left = 5
var current_target_word = ""
var random_word = RandomNumberGenerator.new()

func _ready() -> void:
	random_word.randomize()

func start_new_game():
	load_current_level()

func load_current_level():
	current_level = random_word.randi_range(0, levels.size() - 1)
	current_target_word = levels[current_level]["word"]

func get_current_hint() -> String:
	return levels[current_level]["hint"]

func check_guess(guess_string: String) -> Array:
	#chances_left -= 1
	var result = []
	result.resize(4)
	#var target_character = current_target_word.split("")
	#var remaining_target = current_target_word.split("")
	
	var target_counts = {}
	for i in range(4):
		var character = current_target_word.substr(i, 1)
		target_counts[character] = target_counts.get(character, 0) + 1
	
	#Green Check
	for i in range(4):
		var guess_char = guess_string.substr(i, 1)
		var target_char = current_target_word.substr(i, 1)
		if guess_char == target_char:
			result[i] = "CORRECT"
			#remaining_target[i] = ""
			target_counts[guess_string[i]] -= 1 
		else:
			result[i] = ""
	
	#Yellow Check
	for i in range(4):
		if result[i] != "CORRECT":
			var letter = guess_string.substr(i, 1)
			##var character = remaining_target.find(guess_string[i])
			#if character != -1:
				#result[i] = "PRESENT"
				#remaining_target[character] = ""
			#else:
				#result[i] = "ABSENT"
			
			if target_counts.has(letter) and target_counts[letter] > 0:
				# It is PRESENT in the word and hasn't been used by a GREEN match
				result[i] = "PRESENT"
				target_counts[letter] -= 1 # Mark used
			else:
				result[i] = "ABSENT"
	
	return result

func game_won(guess_string: String) -> bool:
	return guess_string == current_target_word

func next_level():
	load_current_level()
