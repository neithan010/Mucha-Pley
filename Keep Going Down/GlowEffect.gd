extends WorldEnvironment


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spectrum :AudioEffectSpectrumAnalyzerInstance
var magnitudes = []


# Called when the node enters the scene tree for the first time.
func _ready():
	spectrum = AudioServer.get_bus_effect_instance(2,0)
	for _i in range(10):
		magnitudes.append(0.1)
	
func _process(delta):
	var magnitude = spectrum.get_magnitude_for_frequency_range(0, 2000)
	var magnitude_average = magnitude[0]+magnitude[1]
	magnitudes.append(magnitude_average)
	magnitudes.pop_front()
	var sum = 0
	for val in magnitudes:
		sum += val
	
	environment.glow_intensity = 1+ 10*log(sum/magnitudes.size()+1)
