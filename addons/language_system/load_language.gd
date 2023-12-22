@tool
extends EditorPlugin

# Replace this value with a PascalCase autoload name, as per the GDScript style guide.
const AUTOLOAD_NAME = "Godot_Language_System"


func _enter_tree():
	# The autoload can be a scene or script file.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/language_system/language.gd")


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
