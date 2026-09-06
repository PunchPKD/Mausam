extends Control
class_name Widget

enum InformationModes{SIMPLE, DETAILED}
enum WidgetRanks{TOP, MIDDLE, BOTTOM}

@export var simpleInformationElement: Control
@export var detailedInformationElement: Control
@export var focusedInformationElement: Control

var informationMode: InformationModes = InformationModes.SIMPLE
var widgetRank: WidgetRanks = WidgetRanks.BOTTOM:
	set(value):
		if value == WidgetRanks.TOP:
			change_information_element(focusedInformationElement)
		elif value == WidgetRanks.MIDDLE:
			change_information_element(detailedInformationElement)
		elif value == WidgetRanks.BOTTOM:
			change_information_element(simpleInformationElement)
var currentInformationElement: Control

func _ready() -> void:
	if simpleInformationElement:
		simpleInformationElement.visible = false
	if detailedInformationElement:
		detailedInformationElement.visible = false
	currentInformationElement = simpleInformationElement
	if informationMode == InformationModes.SIMPLE:
		change_information_element(simpleInformationElement)
	else :
		change_information_element(detailedInformationElement)
	
func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		pass

func change_information_element(element: Control) -> void:
	if element:
		self.custom_minimum_size = element.size
		currentInformationElement.visible = false
		currentInformationElement = element
		currentInformationElement.visible = true

func remove() -> void:
	SignalBus.RemoveWidget.emit(self)
