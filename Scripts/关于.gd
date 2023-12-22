extends Control


#func _ready():
	#TranslationServer.set_locale("es")


func _unhandled_input(event) -> void:
	if Input.is_action_pressed("归零") or Input.is_action_pressed("ui_menu") or Input.is_action_pressed("ui_home") or Input.is_action_pressed("ui_text_backspace") or Input.is_action_pressed("关于") or Input.is_action_pressed("ui_cancel"):
		_on_返回_pressed()


func _on_返回_pressed():
	get_tree ().change_scene_to_file("res://主界面.tscn")
