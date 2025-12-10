extends CanvasLayer

@onready var gauge_background = $FuelGauge/GaugeBackground
@onready var gauge_fill = $FuelGauge/GaugeFill
@onready var needle = $FuelGauge/Needle
@onready var fuel_label = $FuelGauge/FuelLabel
@onready var distance_value = $DistanceCounter/DistanceValue

# Preload gauge textures (sadece Tachimetrofull kullan, ibre ayrı)
var gauge_bg_low_texture = preload("res://sprites/Tachimetrofull1.png")
var gauge_bg_mid_texture = preload("res://sprites/Tachimetrofull4.png")
var gauge_bg_high_texture = preload("res://sprites/Tachimetrofull6.png")
var gauge_fill_low_texture = preload("res://sprites/Tachimetrofull1.png")
var gauge_fill_mid_texture = preload("res://sprites/Tachimetrofull4.png")
var gauge_fill_high_texture = preload("res://sprites/Tachimetrofull6.png")
var needle_texture = preload("res://sprites/lancetta.png")

var current_fuel: float = 100.0
var max_fuel: float = 100.0

func _ready():
	# Set up gauge sprites
	if gauge_background:
		gauge_background.texture = gauge_bg_high_texture
		print("HUD: GaugeBackground texture set")
	else:
		print("ERROR: GaugeBackground not found!")

	if gauge_fill:
		gauge_fill.texture = gauge_fill_high_texture
		print("HUD: GaugeFill texture set")
	else:
		print("ERROR: GaugeFill not found!")

	if needle:
		needle.texture = needle_texture
		print("HUD: Needle texture set")
	else:
		print("ERROR: Needle not found!")

	update_fuel_display(100.0)
	update_distance_display(0.0)

func update_fuel_display(fuel_percent: float):
	current_fuel = fuel_percent

	# Update label
	fuel_label.text = "FUEL: " + str(int(fuel_percent)) + "%"

	# Change gauge appearance based on fuel level
	if fuel_percent > 66:
		# High fuel - yeşil
		gauge_background.texture = gauge_bg_high_texture
		gauge_fill.texture = gauge_fill_high_texture
		gauge_fill.modulate = Color(1, 1, 1, fuel_percent / 100.0)
	elif fuel_percent > 33:
		# Mid fuel - turuncu
		gauge_background.texture = gauge_bg_mid_texture
		gauge_fill.texture = gauge_fill_mid_texture
		gauge_fill.modulate = Color(1, 0.8, 0, fuel_percent / 100.0)
	else:
		# Low fuel - kırmızı
		gauge_background.texture = gauge_bg_low_texture
		gauge_fill.texture = gauge_fill_low_texture
		gauge_fill.modulate = Color(1, 0.3, 0, fuel_percent / 100.0)

	# Rotate needle based on fuel
	# 100% fuel → 0° (başlangıç, yukarı)
	# 0% fuel → -270° (SOLA 270° döndü, saat yönünün tersine)
	# lerp(from, to, weight): weight 0 = from, weight 1 = to
	# fuel_percent 100 → weight 0 → 0° (başlangıç)
	# fuel_percent 0 → weight 1 → -270° (sola 270° döndü)
	var needle_rotation = lerp(0.0, -270.0, (100.0 - fuel_percent) / 100.0)
	needle.rotation_degrees = needle_rotation

func update_distance_display(distance: float):
	distance_value.text = str(int(distance)) + " m"

func get_current_fuel() -> float:
	return current_fuel
