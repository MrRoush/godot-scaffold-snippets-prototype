@tool
extends EditorPlugin

const DOCK_SCENE := preload("res://addons/scaffold_snippets/ui/scaffold_dock.tscn")

var dock_instance: Control

func _enter_tree() -> void:
	dock_instance = DOCK_SCENE.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UL, dock_instance)
	if dock_instance.has_method("set_services"):
		dock_instance.set_services(
			SnippetLibrary.new(),
			SnippetInserter.new(),
			FriendlyErrorMapper.new()
		)

func _exit_tree() -> void:
	if dock_instance:
		remove_control_from_docks(dock_instance)
		dock_instance.queue_free()

class SnippetLibrary:
	const PACKS := [
		"res://snippets/platformer_pack.json",
		"res://snippets/topdown_pack.json"
	]

	func list_snippets() -> Array:
		var all_snippets: Array = []
		for path in PACKS:
			if not FileAccess.file_exists(path):
				continue
			var raw := FileAccess.get_file_as_string(path)
			if raw.is_empty():
				continue
			var parsed = JSON.parse_string(raw)
			if typeof(parsed) == TYPE_DICTIONARY and parsed.has("snippets"):
				for s in parsed["snippets"]:
					all_snippets.append(s)
		return all_snippets

class SnippetInserter:
	func render_level(snippet: Dictionary, level: int) -> String:
		var code := str(snippet.get("code", ""))
		var comments: Array = snippet.get("comments", [])
		if level <= 1:
			return code
		# Level 2: strip most inline helper comments and keep structure.
		for c in comments:
			code = code.replace("# " + str(c), "")
		return code

	func fill_placeholders(code: String, values: Dictionary) -> String:
		var out := code
		for key in values.keys():
			out = out.replace("{{" + str(key) + "}}", str(values[key]))
		return out

class FriendlyErrorMapper:
	var map := {
		"Expected indented block": {
			"what": "A line needs to move to the right.",
			"why": "Godot expected the code inside a function/if block.",
			"fix": "Select the line and press Tab once."
		},
		"Identifier": {
			"what": "A name was used that Godot does not recognize.",
			"why": "This is often a spelling mismatch.",
			"fix": "Check variable/function spelling and use autocomplete suggestions."
		},
		"Invalid operands": {
			"what": "Two values cannot be used together in this operation.",
			"why": "Types may not match (number vs text).",
			"fix": "Convert one value or use matching data types."
		}
	}

	func explain(error_line: String) -> Dictionary:
		for key in map.keys():
			if error_line.findn(key) != -1:
				return map[key]
		return {
			"what": "Something in this line confused the parser.",
			"why": "The code format or names may be incorrect.",
			"fix": "Read the line slowly and compare to a working snippet."
		}
