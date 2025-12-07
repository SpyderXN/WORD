extends PanelContainer

@onready var letter_label: Label = $Label

# Define Colors
const COLOR_DEFAULT = Color(0.2, 0.2, 0.2) # Dark Gray
const COLOR_CORRECT = Color(0.2, 0.8, 0.2) # Green
const COLOR_PRESENT = Color(0.8, 0.8, 0.2) # Yellow
const COLOR_ABSENT  = Color(0.4, 0.4, 0.4) # Gray

func set_letter(alphabet: String):
	letter_label.text = alphabet.to_upper()

func set_empty():
	letter_label.text = ""
	reset_color()

func set_status(status: String):
	var style = get_theme_stylebox("panel").duplicate()
	
	match status:
		"CORRECT": style.bg_color = COLOR_CORRECT
		"PRESENT": style.bg_color = COLOR_PRESENT
		"ABSENT": style.bg_color = COLOR_ABSENT
		_: style.bg_color = COLOR_DEFAULT
	
	add_theme_stylebox_override("panel", style)

func reset_color():
	var style = get_theme_stylebox("panel").duplicate()
	style.bg_color = COLOR_DEFAULT
	add_theme_stylebox_override("panel", style)
