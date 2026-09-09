extends Node

@export var saveFile: BaseSaveFile

var currentSaveFile: BaseSaveFile

func _ready() -> void:
	load_widget_data()
	await get_tree().process_frame
	SignalBus.update_data()

func load_widget_data() -> void:
	SignalBus.Datas = saveFile.widgetsData.duplicate()
	currentSaveFile = saveFile

func save_widget_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	currentSaveFile.widgetsData = data
	ResourceSaver.save(currentSaveFile)

func load_save_file(file: BaseSaveFile) -> void:
	SignalBus.Datas = file.widgetsData.duplicate()
	currentSaveFile = file
	SignalBus.update_data()
	SignalBus.SaveFileChanged.emit(file)
