extends Control

var fsm
func buildRef(fsmPara): 
	fsm = fsmPara

func _enter_tree() -> void: 
	get_node("AnimationPlayer").play("enter")
	pass




func exitAnimation(fsmPara):
	fsm = fsmPara
	get_node("AnimationPlayer").play("RightToLeft")
	self.queue_free()


#func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
#	if anim_name == "LeftToRight":
#		fsm.playEnterAnimation()
#		self.queue_free()
