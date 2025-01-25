class_name State_Stun extends State

# store a refernece to the player this belongs to

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerabilty_duration: float = 1.0

@onready var idle: State = $"../Idle"
@onready var attack: State_Attack = $"../Attack"

var hurt_box: HurtBox
var direction: Vector2

var next_state: State = null

#what happens when we initialize this state
func init() -> void:
	player.player_damaged.connect(_player_damaged)
	pass
	
#what happens when the player enters this state
func Enter() -> void:
	
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	
	player.UpdateAnimation("stun")
	player.make_invulnerable(invulnerabilty_duration)
	player.effect_animation_player.play("damaged")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed*_delta
	return next_state
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> State:
	return null
	
	#what happens during input events in this state
func HandleInput(_event: InputEvent) -> State:
	return null
	
func _player_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.ChangeState(self)
	pass

func _animation_finished(_a: String) -> void:
	next_state = idle
	pass
