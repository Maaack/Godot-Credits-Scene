@tool
extends AcceptDialog

## Optional link to webpage for reporting issues. Must start with "https://"
@export var issues_url : String

@onready var plugin_label : Label = %PluginLabel
@onready var copy_check_box : CheckBox = %CopyCheckBox
@onready var copy_button : Button = %CopyButton
@onready var delete_check_box : CheckBox = %DeleteCheckBox
@onready var delete_button : Button = %DeleteButton
@onready var issues_link_label = %IssuesLink

func _refresh_plugin_details() -> void:
	for enabled_plugin in ProjectSettings.get_setting("editor_plugins/enabled"):
		if enabled_plugin.contains(MaaacksCreditsScene.get_settings_path()):
			var config := ConfigFile.new()
			var error = config.load(enabled_plugin)
			if error != OK:
				return
			var current_plugin_version : String = config.get_value("plugin", "version", "0.0.0")
			var plugin_name : String = config.get_value("plugin", "name", "Plugin")
			plugin_label.text = "%s v%s" % [plugin_name, current_plugin_version]

func _refresh_copy_and_delete_examples() -> void:
	var examples_path = MaaacksCreditsScenePlugin.instance.get_plugin_examples_path()
	if MaaacksCreditsScenePlugin.instance.get_copy_path() != examples_path:
		copy_check_box.button_pressed = true
	var dir := DirAccess.open("res://")
	if dir.dir_exists(examples_path):
		copy_button.disabled = false
		delete_button.disabled = false
	else:
		delete_check_box.button_pressed = true

func _refresh_report_an_issue_link() -> void:
	issues_link_label.visible = not issues_url.is_empty()

func _refresh_options():
	_refresh_plugin_details()
	_refresh_copy_and_delete_examples()
	_refresh_report_an_issue_link()

func _ready():
	_refresh_options()

func _on_copy_button_pressed():
	tree_exited.connect(func(): MaaacksCreditsScenePlugin.instance.open_copy_and_edit_dialog())
	queue_free()

func _on_delete_button_pressed():
	tree_exited.connect(func(): MaaacksCreditsScenePlugin.instance.open_delete_examples_short_confirmation_dialog())
	queue_free()

func _on_issues_link_meta_clicked(meta):
	if (not issues_url.is_empty()) and issues_url.begins_with("https://"):
		var _err = OS.shell_open(issues_url)
