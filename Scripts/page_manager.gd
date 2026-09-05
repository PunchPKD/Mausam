extends Control
class_name PageManager

@export var personalisedPage: Control
@export var aiOverViwePage: Control

func _on_ai_over_view_page_button_button_up() -> void:
	aiOverViwePage.visible = true
	personalisedPage.visible = false


func _on_personalised_page_button_button_up() -> void:
	aiOverViwePage.visible = false
	personalisedPage.visible = true
