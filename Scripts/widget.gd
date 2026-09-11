extends Control
class_name Widget

enum InformationModes{SIMPLE, DETAILED, FOCUSED}
enum WidgetRanks{TOP, MIDDLE, BOTTOM}

@export var simpleInformationElement: Control
@export var detailedInformationElement: Control
@export var focusedInformationElement: Control
@export var dataType: DataTypeEnum.DataTypes
@export var label: Label
@export var minValue: int
@export var maxValue: int
@export var colorCoded: bool = false
@export var widgetTags: Array[TagsEnum.WeatherTags]

var widgetScore: int

var green: Color = Color("7aff99ff")
var yellow: Color = Color("ffff3dff")
var red: Color = Color("fc2828ff")

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
	if label and datas.has(dataType):
		label.text = datas.get(dataType)
		set_label_color(int(datas.get(dataType)))
	
func set_label_color(data:int) -> void:
	if colorCoded == false:
		return
	var step: int = int((maxValue - minValue)/3)
	var greenFlag: int = step + minValue
	var yellowFlag: int = maxValue - step
	if data <= greenFlag:
		label.modulate = green
	elif data <= yellowFlag:
		label.modulate = yellow
	else:
		label.modulate = red

func on_reset_widget_score() -> void:
	widgetScore = 0

func on_increase_widget_score(tag: TagsEnum.WeatherTags) -> void:
	for tempTag in widgetTags:
		if tempTag == tag:
			widgetScore += 1
