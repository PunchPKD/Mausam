extends Node

@export var saveFile: BaseSaveFile

func _ready() -> void:
	load_widget_data()
	await get_tree().process_frame
	SignalBus.update_data()

func load_widget_data() -> void:
	SignalBus.Datas = saveFile.widgetsData.duplicate()

func save_widget_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	saveFile.widgetsData = data
	ResourceSaver.save(saveFile)
