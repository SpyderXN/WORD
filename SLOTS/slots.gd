extends PanelContainer

@onready var letter_label: Label = $Label

func set_letter(alphabet: String):
	letter_label.text = alphabet.to_upper()

func set_empty():
	letter_label.text = ""
