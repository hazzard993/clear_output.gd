@tool
extends EditorPlugin

func _enter_tree() -> void:
	_on()


func _exit_tree() -> void:
	_off()


func _on() -> void:
	EditorInterface.get_command_palette().add_command(
		"Clear Output",
		"clear_output",
		_clear_output,
	)


func _off() -> void:
	EditorInterface.get_command_palette().remove_command("clear_output")


func _clear_output():
	pressClearButton()


func pressClearButton() -> void:
	var shortcut := EditorInterface.get_editor_settings().get_shortcut("editor/clear_output").get_as_text()
	var root := EditorInterface.get_inspector().get_tree().root
	_pressClearButton(root, shortcut)


func _pressClearButton(node: Node, shortcutText: String) -> bool:
	for i in node.get_child_count():
		var child := node.get_child(i)
		if child is Button:
			var b := child as Button
			if b.shortcut:
				if b.shortcut.get_as_text() == shortcutText:
					b.pressed.emit()
					return true
		if child.get_child_count() > 0:
			if _pressClearButton(child, shortcutText):
				return true
	return false
