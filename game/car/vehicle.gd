
extends VehicleBody

# Member variables
const STEER_LIMIT = 1 #radians
var steer_inc = 0.02 #radians


export var engine_force = 40

#speed
var speed
var speed_int = 0
var speed_kph = 0

#lights
var headlight_one
var headlight_two

func process_car_physics(gas, brake, left, right):
	speed = get_linear_velocity().length();
	
	#gas
	if (gas): #(Input.is_action_pressed("ui_up")):
		set_engine_force(engine_force)
	else:
		if (speed > 3):
			set_engine_force(-engine_force/4)
		else:
			set_engine_force(0)
	
	#brake/reverse
	if (brake): #(Input.is_action_pressed("ui_down")):
		if (speed > 5):
			#slows down 1 unit per tick
			set_brake(1)
		else:
			#reverse
			set_brake(0.0)
			set_engine_force(-engine_force)
	else:
		set_brake(0.0)
	
	#steering
	if (left and get_steering() > -STEER_LIMIT): #(Input.is_action_pressed("ui_left") and get_steering() > -STEER_LIMIT):
		set_steering(get_steering()-steer_inc)
	if (right and get_steering() < STEER_LIMIT): #(Input.is_action_pressed("ui_right") and get_steering() < STEER_LIMIT):
		set_steering(get_steering()+steer_inc)

	
func _fixed_process(delta):
	#just to have something here
	var basis = get_transform().basis.y


func _ready():
	#get lights
	headlight_one = get_node("SpotLight")
	headlight_two = get_node("SpotLight1")
	
func setHeadlights(on):
	if (on):
		headlight_one.set_enabled(true)
		headlight_two.set_enabled(true)
	else:
		headlight_one.set_enabled(false)
		headlight_two.set_enabled(false)