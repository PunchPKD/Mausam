extends Control

@export var dataType: DataTypeEnum.DataTypes

func _on_line_edit_text_submitted(new_text: String) -> void:
	SignalBus.set_data(dataType, new_text)
