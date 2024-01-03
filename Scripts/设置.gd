extends Control


@onready var 语言 = $"面板/背景色/MarginContainer/色/内容按钮分隔/正文和标题分隔2/语言"


func _ready():
	var locale = OS.get_locale()
	if locale == "zh_CN":
		_on_语言_item_selected(0)
	elif locale == "zh_TW":
		_on_语言_item_selected(1)
	elif locale == "en":
		_on_语言_item_selected(2)
	elif locale == "jp":
		_on_语言_item_selected(3)
	elif locale == "es":
		_on_语言_item_selected(4)


@warning_ignore("unused_parameter")
func _unhandled_input(event) -> void:
	if Input.is_action_pressed("归零") or Input.is_action_pressed("ui_menu") or Input.is_action_pressed("ui_home") or Input.is_action_pressed("ui_text_backspace") or Input.is_action_pressed("关于") or Input.is_action_pressed("ui_cancel"):
		_on_返回_pressed()


func _on_返回_pressed():
	get_tree ().change_scene_to_file("res://主界面.tscn")


func _on_语言_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("zh")
	elif index == 1:
		TranslationServer.set_locale("zht")
	elif index == 2:
		TranslationServer.set_locale("en")
	elif index == 3:
		TranslationServer.set_locale("jp")
	elif index == 4:
		TranslationServer.set_locale("es")
