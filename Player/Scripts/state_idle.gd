class_name State_Idle extends State

# store a refernece to the player this belongs to
@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


#what happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
		
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> State:
	return null
	
	#what happens during input events in this state
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	return null
	
	
