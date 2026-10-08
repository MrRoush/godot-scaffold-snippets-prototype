@tool
extends VBoxContainer

var library
var inserter
var error_mapper
var snippets: Array = []

@onready var snippet_list: ItemList = $SnippetList
@onready var level_select: OptionButton = $Controls/LevelSelect
@onready var error_input: LineEdit = $ErrorInput
@onready var error_out: RichTextLabel = $ErrorOut

func set_services(p_library, p_inserter, p_error_mapper) -> void:
	library = p_library
	inserter = p_inserter
	error_mapper = p_error_mapper
	_refresh()

func _ready() -> void:
	level_select.add_item("1 - Full Scaffold")
	level_select.add_item("2 - Reduced Hints")
	if library and snippets.is_empty():
		_refresh()
	$Controls/InsertButton.pressed.connect(_on_insert_pressed)
	$ExplainButton.pressed.connect(_on_explain_pressed)

func _refresh() -> void:
	if library == null:
		return
	snippets = library.list_snippets()
	snippet_list.clear()
	for s in snippets:
		snippet_list.add_item(str(s.get("title", "Untitled Snippet")))

func _on_insert_pressed() -> void:
	if snippet_list.get_selected_items().is_empty():
		_error("Select a snippet first.")
		return
	var idx: int = snippet_list.get_selected_items()[0]
	var snippet: Dictionary = snippets[idx]
	var level: int = level_select.get_selected_id() + 1
	var code: String = inserter.render_level(snippet, level)
	# Placeholder defaults for demo preview only.
	var defaults: Dictionary = {
		"speed": 220,
		"jump_power": -420,
		"left": "move_left",
		"right": "move_right",
		"jump": "jump",
		"target_group": "Player"
	}
	code = inserter.fill_placeholders(code, defaults)
	error_out.text = "[b]Snippet Preview[/b]\n\n" + code

func _on_explain_pressed() -> void:
	if error_mapper == null:
		return
	var result: Dictionary = error_mapper.explain(error_input.text)
	error_out.text = "[b]What[/b]: %s\n[b]Why[/b]: %s\n[b]Fix[/b]: %s" % [
		result.get("what", ""),
		result.get("why", ""),
		result.get("fix", "")
	]

func _error(msg: String) -> void:
	error_out.text = "[color=red]%s[/color]" % msg
