class_name HurtBox extends Area2D

@export var damage: int  = 1

func _ready() -> void:
	area_entered.connect(AreaEnetered)
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
	pass
