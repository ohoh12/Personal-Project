extends KinematicBody

class_name Player

export var acceleration = 100
export var friction = 0.85
export var gravity = 80
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var HeadNode = $Head
onready var CameraNode = $Head/Camera

var vel = Vector3()

var camera_change = Vector2()


func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	
	if event is InputEventMouseMotion:
		camera_change = event.relative

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	aim()
	walk(delta)
	jump(delta)
	vel = move_and_slide(vel, Vector3.UP, true, 4) 

func aim():
	if not camera_change.length(): return 

	HeadNode.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))

	CameraNode.rotate_x(deg2rad(-camera_change.y * mouse_sensitivity))

	camera_change = Vector2()

	
func walk(delta):	

	var head_rotation = HeadNode.get_global_transform().basis
	
	var move_direction = Vector3()
	
	if Input.is_action_pressed("move_forward"):
		
		move_direction -= head_rotation.z
	elif Input.is_action_pressed("move_back"):
		move_direction += head_rotation.z
	if Input.is_action_pressed("move_left"):
		move_direction -= head_rotation.x
	elif Input.is_action_pressed("move_right"):
		move_direction += head_rotation.x
	move_direction = move_direction.normalized()

	
	vel += move_direction*acceleration*delta
	
	vel *= friction
	
	vel.y -= gravity*delta

func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y += jump_power
