class_name EnemyStateWander extends EnemyState

@export var anim_name: String = "walk"
@export var wander_Speed: float = 20.0

@export_category("AI")
@export var state_animation_duration: float = 0.7
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: EnemyState

var mega_size: int = 5
var mega_slime
var _timer: float = 0.0
var _direction: Vector2
#what happens when we initialize this state
func init() -> void:
	var rand = randi_range(0,5)
	if rand == 0:
		mega_slime = true
	pass

#what happens when the player enters this state
func Enter() -> void:
	_timer = randi_range(state_cycles_min,state_cycles_max) * state_animation_duration
	var rand = randi_range(0,3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_Speed
	enemy.SetDirection(_direction)
	enemy.UpdateAnimation(anim_name)
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	_timer -=_delta
	if _timer <= 0:
		return next_state
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
