extends Node

var Datas: Dictionary[DataTypeEnum.DataTypes, String]

signal AddWidget(widgetScene: PackedScene)
signal RemoveWidget(widgetScene: PackedScene)
signal AddWidgetList(widgetData: BaseWidgetData)
signal SelectElement(element: Control)
signal StartHCloudAnimation(direction: int)
signal StartCloudColorAnimation(color: Color)
signal ToggleLocationSelectionOverlay()
signal UpdateData(datas: Dictionary[DataTypeEnum.DataTypes, String])
signal UpdateWidgetScore()
signal SaveFileChanged(file: BaseSaveFile)
signal IncreaseWidgetScore(tag: TagsEnum.WeatherTags)
signal ResetWidgetScore()
signal ResetRecommendation()
signal AddRecommendation(widgetScene: PackedScene)
signal ToggleRecommendation()

func set_data(dataType: DataTypeEnum.DataTypes, value: String) -> void:
	Datas[dataType] = value

func update_data() -> void:
	ResetWidgetScore.emit()
	await get_tree().process_frame
	UpdateData.emit(Datas)
	UpdateWidgetScore.emit()
	SaveManager.save_widget_data(Datas)

func update_widget_score() -> void:
	ResetWidgetScore.emit()
	await get_tree().process_frame
	UpdateWidgetScore.emit()
