extends Control
class_name Widget

enum InformationModes{SIMPLE, DETAILED, FOCUSED}
enum WidgetRanks{TOP, MIDDLE, BOTTOM}

@export var simpleInformationElement: Control
@export var detailedInformationElement: Control
@export var focusedInformationElement: Control
@export var dataType: DataTypeEnum.DataTypes
@export var label: Label

var informationMode: InformationModes = InformationModes.SIMPLE:
	set(value):
		informationMode = value
		if value == InformationModes.FOCUSED:
			change_information_element(focusedInformationElement)
		elif value == InformationModes.DETAILED:
			change_information_element(detailedInformationElement)
		elif value == InformationModes.SIMPLE:
			change_information_element(simpleInformationElement)
	
var widgetRank: WidgetRanks = WidgetRanks.BOTTOM
var currentInformationElement: Control

func _ready() -> void:
	SignalBus.UpdateData.connect(on_update_data)
	on_update_data(SaveManager.saveFile.widgetsData)
	
func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		SignalBus.SelectElement.emit(self)

func change_information_element(element: Control) -> void:
	if element:
		self.custom_minimum_size = element.size
		self.custom_maximum_size = element.size
		if currentInformationElement:
			currentInformationElement.visible = false
		currentInformationElement = element
		currentInformationElement.visible = true

func on_update_data(datas: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if label:
		label.text = datas.get(dataType)
