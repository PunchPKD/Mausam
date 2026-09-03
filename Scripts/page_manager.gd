extends MarginContainer
class_name PageManager

var currentPage: Control

@export var informationPage: Control
@export var widgetSelectionPage: Control

func _ready() -> void:
	for child in get_children():
		if child is Control:
			child.visible = true
	currentPage = informationPage
	change_page(informationPage)

func change_page(page: Control) -> void:
	currentPage.visible = false
	currentPage = page
	currentPage.visible = true

func _on_toggle_edit_mode_button_button_up() -> void:
	if informationPage.visible == true:
		change_page(widgetSelectionPage)
	else:
		change_page(informationPage)
