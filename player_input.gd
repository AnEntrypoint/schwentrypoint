extends MultiplayerSynchronizer

# Set via RPC to simulate is_action_just_pressed.
@export var jumping := false

@export var crouch := false
@export var running := false

@export var direction := Vector3()

@export var player := 1 :
	set(id):
		player = id

@export_enum("ThirdPerson", "FirstPerson") var cameraType:int = 0
@export var is_on_floor = false
var wannajump = 0
@export var input_dir = Vector3()

func _ready():
	# Only process for the local player
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

func _process(_delta):
	if wannajump:
		wannajump += _delta
	if Input.is_action_just_pressed("jump"):
		wannajump = 0.0001
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	if wannajump < 0.3 and wannajump != 0 and is_on_floor and !crouch:
		jumping = true
		wannajump = 0
	if Input.is_action_just_pressed("jump") and is_on_floor and !crouch:
		jumping = true
		wannajump = 0
	if Input.is_action_just_pressed("Crouch"):
		crouch = true
	if Input.is_action_just_pressed("camSwitch"):
		cameraType = !cameraType
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	
	if !crouch && Input.is_action_pressed("Run"):
		running = true
	else:
		running = false
	


	
