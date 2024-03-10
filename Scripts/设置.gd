extends Control


#@onready var 本场景 = $"面板"
@onready var 语言 = $"面板/背景色/MarginContainer/色/内容按钮分隔/正文和标题分隔2/语言"


@warning_ignore("unused_parameter")
func _unhandled_input(event) -> void:
    if Input.is_action_pressed("归零") or Input.is_action_pressed("ui_menu") or Input.is_action_pressed("ui_home") or Input.is_action_pressed("ui_text_backspace") or Input.is_action_pressed("关于") or Input.is_action_pressed("ui_cancel"):
        _on_返回_pressed()


func _ready():
    #本场景.set("theme", "res://Assets/样式/得意黑字体.tres")
    语言.selected = Global.读取设置()


func _on_返回_pressed():
    get_tree ().change_scene_to_file("res://主界面.tscn")


func _on_语言_item_selected(index):
    Global.切换并保存(index)
