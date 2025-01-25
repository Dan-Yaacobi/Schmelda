class_name EnemyStateStun extends EnemyState

@export var anim_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export var evolve_chance = 7
@export_category("AI")
@export var after_stun_state: EnemyState

var tried_to_evolve: bool = false

signal enemy_evolved()

var _damage_position: Vector2
var _direction: Vector2
var _animation_finished: bool = false

#what happens when we initialize this state
func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damage)
	pass

#what happens when the enemy enters this state
func Enter() -> void:
	if enemy.can_evolve:
		if not tried_to_evolve:
			var random = randi_range(0,evolve_chance)
			if random == 0:
				enemy_evolved.emit(true)
			else:
				enemy_evolved.emit(false)
			tried_to_evolve = true
			
	enemy.invulrable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to(_damage_position)
	
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
#what happens when the enemy exits this state
func Exit() -> void:
	enemy.invulrable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	if _animation_finished == true:
		return after_stun_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
func _on_enemy_damage(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState(self)
	pass
	
func _on_animation_finished(_a: String) -> void:
	_animation_finished = true
	pass
	
