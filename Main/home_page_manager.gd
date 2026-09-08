extends Control
class_name HomePageManager

@export var simulationPage: Control
@export var simulateButton: TextureButton

@export var label: Label
@export var background: Panel
@export var rainParticle: CPUParticles2D

func _ready() -> void:
	SignalBus.UpdateData.connect(on_update_data)

func on_update_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if data.get(DataTypeEnum.DataTypes.Weather) == null:
		return
	var tempInt: int = int(data.get(DataTypeEnum.DataTypes.Weather))
	if tempInt == WeatherTypeEnum.WeatherType.Clear:
		label.text = "Clear"
		rainParticle.emitting = false
		animate_background_color(Color(0.294, 0.711, 0.89, 1.0))
		SignalBus.StartCloudColorAnimation.emit(Color(1.0, 1.0, 1.0, 0.0))
	elif tempInt == WeatherTypeEnum.WeatherType.Cloudy:
		label.text = "Cloudy"
		rainParticle.emitting = false
		animate_background_color(Color(0.294, 0.711, 0.89, 1.0))
		SignalBus.StartCloudColorAnimation.emit(Color(1.0, 1.0, 1.0, 1.0))
	elif tempInt == WeatherTypeEnum.WeatherType.Fog:
		label.text = "Fog"
		rainParticle.emitting = false
		animate_background_color(Color(0.544, 0.64, 0.64, 1.0))
		SignalBus.StartCloudColorAnimation.emit(Color(0.826, 0.826, 0.826, 1.0))
	elif tempInt == WeatherTypeEnum.WeatherType.Rain:
		label.text = "Rain"
		rainParticle.emitting = true
		rainParticle.amount = 18
		rainParticle.initial_velocity_max = 700
		animate_background_color(Color(0.378, 0.43, 0.43, 1.0))
		SignalBus.StartCloudColorAnimation.emit(Color(0.617, 0.617, 0.617, 1.0))
	elif tempInt == WeatherTypeEnum.WeatherType.Thunderstrom:
		label.text = "Thunderstrom"
		rainParticle.emitting = true
		rainParticle.amount = 26
		rainParticle.initial_velocity_min = 800
		animate_background_color(Color(0.196, 0.22, 0.22, 1.0))
		SignalBus.StartCloudColorAnimation.emit(Color(0.486, 0.486, 0.486, 1.0))

func animate_background_color(color: Color) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(background,"modulate",color,0.3)

func _on_texture_button_button_up() -> void:
	toogle_visiblity(simulationPage)
	
func toogle_visiblity(element: Control) -> void:
	element.visible = !element.visible


func _on_button_button_up() -> void:
	toogle_visiblity(simulationPage)
