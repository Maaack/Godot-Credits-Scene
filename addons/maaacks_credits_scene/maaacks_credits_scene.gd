@tool
class_name MaaacksCreditsScenePlugin
extends EditorPlugin

const APIClient = preload("res://addons/maaacks_credits_scene/utilities/api_client.gd")
const DownloadAndExtract = preload("res://addons/maaacks_credits_scene/utilities/download_and_extract.gd")
const CopyAndEdit = preload("res://addons/maaacks_credits_scene/installer/copy_and_edit_files.gd")

const PLUGIN_NAME = "Maaack's Credits Scene"
const PROJECT_SETTINGS_PATH = "maaacks_credits_scene/"

const EXAMPLES_RELATIVE_PATH = "examples/"
const MAIN_SCENE_RELATIVE_PATH = "scenes/end_credits/end_credits.tscn"
const WINDOW_OPEN_DELAY : float = 0.5
const RUNNING_CHECK_DELAY : float = 0.25

var selected_theme : String
var update_plugin_tool_string : String

func _get_plugin_name() -> String:
	return PLUGIN_NAME

func get_plugin_path() -> String:
	return get_script().resource_path.get_base_dir() + "/"

func get_plugin_examples_path() -> String:
	return get_plugin_path() + EXAMPLES_RELATIVE_PATH

func _open_play_opening_confirmation_dialog(target_path : String):
	var play_confirmation_scene : PackedScene = load(get_plugin_path() + "installer/play_opening_confirmation_dialog.tscn")
	var play_confirmation_instance : ConfirmationDialog = play_confirmation_scene.instantiate()
	play_confirmation_instance.confirmed.connect(_run_opening_scene.bind(target_path))
	add_child(play_confirmation_instance)

func _open_delete_examples_confirmation_dialog(target_path : String) -> void:
	var delete_confirmation_scene : PackedScene = load(get_plugin_path() + "installer/delete_examples_confirmation_dialog.tscn")
	var delete_confirmation_instance : ConfirmationDialog = delete_confirmation_scene.instantiate()
	delete_confirmation_instance.confirmed.connect(_delete_source_examples_directory.bind(target_path))
	add_child(delete_confirmation_instance)

func _open_delete_examples_short_confirmation_dialog() -> void:
	var delete_confirmation_scene : PackedScene = load(get_plugin_path() + "installer/delete_examples_short_confirmation_dialog.tscn")
	var delete_confirmation_instance : ConfirmationDialog = delete_confirmation_scene.instantiate()
	delete_confirmation_instance.confirmed.connect(_delete_source_examples_directory)
	add_child(delete_confirmation_instance)

func _run_opening_scene(target_path : String) -> void:
	var opening_scene_path = target_path + MAIN_SCENE_RELATIVE_PATH
	EditorInterface.play_custom_scene(opening_scene_path)
	var timer: Timer = Timer.new()
	var callable := func() -> void:
		if EditorInterface.is_playing_scene(): return
		timer.stop()
		_open_delete_examples_confirmation_dialog(target_path)
		timer.queue_free()
	timer.timeout.connect(callable)
	add_child(timer)
	timer.start(RUNNING_CHECK_DELAY)

func _delete_directory_recursive(dir_path : String) -> void:
	if not dir_path.ends_with("/"):
		dir_path += "/"
	var dir = DirAccess.open(dir_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var error : Error
		while file_name != "" and error == 0:
			var relative_path = dir_path.trim_prefix(get_plugin_examples_path())
			var full_file_path = dir_path + file_name
			if dir.current_is_dir():
				_delete_directory_recursive(full_file_path)
			else:
				error = dir.remove(file_name)
			file_name = dir.get_next()
		if error:
			push_error("plugin error - deleting path: %s" % error)
	else:
		push_error("plugin error - accessing path: %s" % dir)
	dir.remove(dir_path)

func _delete_source_examples_directory(target_path : String = "") -> void:
	var examples_path = get_plugin_examples_path()
	var dir := DirAccess.open("res://")
	if dir.dir_exists(examples_path):
		_delete_directory_recursive(examples_path)
		EditorInterface.get_resource_filesystem().scan()
		remove_tool_menu_item("Copy " + _get_plugin_name() + " Examples...")
		remove_tool_menu_item("Delete " + _get_plugin_name() + " Examples...")

func _on_completed_copy_to_directory(target_path : String) -> void:
	ProjectSettings.set_setting(PROJECT_SETTINGS_PATH + "copy_path", target_path)
	ProjectSettings.save()
	_open_play_opening_confirmation_dialog(target_path)

func _open_copy_and_edit_dialog() -> void:
	var copy_and_edit_scene : PackedScene = load(get_plugin_path() + "installer/copy_and_edit_files.tscn")
	var copy_and_edit_instance : CopyAndEdit = copy_and_edit_scene.instantiate()
	copy_and_edit_instance.completed.connect(_on_completed_copy_to_directory)
	add_child(copy_and_edit_instance)

func _open_confirmation_dialog() -> void:
	var confirmation_scene : PackedScene = load(get_plugin_path() + "installer/copy_confirmation_dialog.tscn")
	var confirmation_instance : ConfirmationDialog = confirmation_scene.instantiate()
	confirmation_instance.confirmed.connect(_open_copy_and_edit_dialog)
	add_child(confirmation_instance)

func _open_check_plugin_version() -> void:
	if ProjectSettings.has_setting(PROJECT_SETTINGS_PATH + "disable_update_check"):
		if ProjectSettings.get_setting(PROJECT_SETTINGS_PATH + "disable_update_check"):
			return
	else:
		ProjectSettings.set_setting(PROJECT_SETTINGS_PATH + "disable_update_check", false)
		ProjectSettings.save()
	var check_version_scene : PackedScene = load(get_plugin_path() + "installer/check_plugin_version.tscn")
	var check_version_instance : Node = check_version_scene.instantiate()
	check_version_instance.auto_start = true
	check_version_instance.new_version_detected.connect(_add_update_plugin_tool_option)
	add_child(check_version_instance)

func _open_update_plugin() -> void:
	var update_plugin_scene : PackedScene = load(get_plugin_path() + "installer/update_plugin.tscn")
	var update_plugin_instance : Node = update_plugin_scene.instantiate()
	update_plugin_instance.auto_start = true
	update_plugin_instance.update_completed.connect(_remove_update_plugin_tool_option)
	add_child(update_plugin_instance)

func _add_update_plugin_tool_option(new_version : String) -> void:
	update_plugin_tool_string = "Update %s to v%s..." % [_get_plugin_name(), new_version]
	add_tool_menu_item(update_plugin_tool_string, _open_update_plugin)

func _remove_update_plugin_tool_option() -> void:
	if update_plugin_tool_string.is_empty(): return
	remove_tool_menu_item(update_plugin_tool_string)
	update_plugin_tool_string = ""

func _show_plugin_dialogues() -> void:
	if ProjectSettings.has_setting(PROJECT_SETTINGS_PATH + "disable_install_wizard") :
		if ProjectSettings.get_setting(PROJECT_SETTINGS_PATH + "disable_install_wizard") :
			return
	_open_confirmation_dialog()
	ProjectSettings.set_setting(PROJECT_SETTINGS_PATH + "disable_install_wizard", true)
	ProjectSettings.save()

func _add_tool_options() -> void:
	var examples_path = get_plugin_examples_path()
	var dir := DirAccess.open("res://")
	if dir.dir_exists(examples_path):
		add_tool_menu_item("Copy " + _get_plugin_name() + " Examples...", _open_copy_and_edit_dialog)
		add_tool_menu_item("Delete " + _get_plugin_name() + " Examples...", _open_delete_examples_short_confirmation_dialog)
	_open_check_plugin_version()

func _remove_tool_options() -> void:
	var examples_path = get_plugin_examples_path()
	var dir := DirAccess.open("res://")
	if dir.dir_exists(examples_path):
		remove_tool_menu_item("Copy " + _get_plugin_name() + " Examples...")
		remove_tool_menu_item("Delete " + _get_plugin_name() + " Examples...")
	remove_tool_menu_item("Use Input Icons for " + _get_plugin_name() + "...")
	_remove_update_plugin_tool_option()

func _enter_tree() -> void:
	_add_tool_options()
	_show_plugin_dialogues()

func _exit_tree() -> void:
	_remove_tool_options()
