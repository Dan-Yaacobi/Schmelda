class_name Enemy extends CharacterBody2D

signal DirectionChange(new_direction: Vector2)
signal enemy_damaged(hurt_box: HurtBox)
signal enemy_destroyed(hurt_box: HurtBox)


const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]
@export var hp: int = 3
@export var can_evolve: bool = false

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulrable: bool = false
var player: Player

@onready var shadow_sprite = $ShadowSprite

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stun_state: EnemyState = $EnemyStateMachine/Stun

@onready var destroy: EnemyStateDestroy = $EnemyStateMachine/Destroy

func _ready() -> void:
	state_machine.Initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	#print("name: ", self.name)
	pass


func _process(delta: float) -> void:
	
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func SetDirection(_new_direction: Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
		#This line gets an angle and normalize it between 0 - 3 to get the direction
		# diving by TAU gets a number between 0 and 1
	var direction_id: int = int(round( (direction + cardinal_direction * 0.1).angle()
	 / TAU * DIR_4.size() 
	))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	DirectionChange.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurt_box: HurtBox) -> void:
	if invulrable == true:
		return
	hp -= hurt_box.damage 
	if hp > 0:
		enemy_damaged.emit(hurt_box)
	else:
		enemy_destroyed.emit(hurt_box)	
	pass
	

#func evolve(success: bool) -> void:
	#if success:
		#self.scale *= 2
		#self.hp = 5
		#for drop in destroy.drops:
			#if drop.item.name == "Gem":
				#drop.min_amount = 4
			#elif drop.item.name == "Apple":
				#drop.probability = 0
			#elif drop.item.name == "Potion":
				#drop.probability = 50
	#else:
		#for drop in destroy.drops:
			#if drop.item.name == "Gem":
				#drop.min_amount = 1
			#elif drop.item.name == "Apple":
				#drop.probability = 33
			#elif drop.item.name == "Potion":
				#drop.probability = 0
	#pass
	#
#func adjust_drop_rate(drops: Array[DropData]) 
