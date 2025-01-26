class_name LogCommand
extends Command

var tex : Texture
var text : String

func _init(tex, text) -> void:
	self.tex = tex
	self.text = text
	
func execute():
	Globals.main.logToLog(tex, text)
	completed = true
