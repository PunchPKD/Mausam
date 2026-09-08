extends Control
class_name HomePageManager

@export var simulationPage: Control
@export var simulateButton: TextureButton


func _on_texture_button_button_up() -> void:
	toogle_visiblity(simulationPage)
	
func toogle_visiblity(element: Control) -> void:
	element.visible = !element.visible
