extends Control
class_name LocationSelector

@export var saveFile: BaseSaveFile

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_released("Click"):
		SaveManager.load_save_file(saveFile)
		SignalBus.ToggleLocationSelectionOverlay.emit()
