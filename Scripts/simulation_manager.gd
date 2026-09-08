extends Control
class_name SimulationManager

func simulate() -> void:
	SignalBus.update_data()

func _on_button_button_up() -> void:
	simulate()
