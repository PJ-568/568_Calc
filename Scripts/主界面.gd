extends Control


@onready var 历史 = $"面板/背景色/屏键容器/结果显示容器/MarginContainer/VBoxContainer/上个工作区"
@onready var 工作区 = $"面板/背景色/屏键容器/结果显示容器/MarginContainer/VBoxContainer/工作区"
@onready var 所有按钮 = $"面板/背景色/屏键容器/MarginContainer2/上下键盘分隔"

var 已被使用 := false	##工作区内是否有数字
var 第一个数字 : float
var 第二个数字 : float
var 运算符 := ""
var 小数否 := false	##工作区内是否为小数（防止两个小数点出现）

# 初始化
func _ready():
	for Buttons in 所有按钮.get_children():
		for btn in Buttons.get_children():
			if btn.name.is_valid_int():
				btn.pressed.connect(Callable(self, "_number_buttons").bind(btn))


func _unhandled_input(event) -> void:
	if Input.is_action_pressed("ui_text_backspace") or Input.is_action_pressed("ui_cancel"):
		按下退格()
	if Input.is_action_pressed("1"):
		按下数字按钮("1")
	if Input.is_action_pressed("2"):
		按下数字按钮("2")
	if Input.is_action_pressed("3"):
		按下数字按钮("3")
	if Input.is_action_pressed("4"):
		按下数字按钮("4")
	if Input.is_action_pressed("5"):
		按下数字按钮("5")
	if Input.is_action_pressed("6"):
		按下数字按钮("6")
	if Input.is_action_pressed("7"):
		按下数字按钮("7")
	if Input.is_action_pressed("8"):
		按下数字按钮("8")
	if Input.is_action_pressed("9"):
		按下数字按钮("9")
	if Input.is_action_pressed("0"):
		按下数字按钮("0")
	if Input.is_action_pressed("点"):
		按下点()
	if Input.is_action_pressed("归零") or Input.is_action_pressed("ui_menu") or Input.is_action_pressed("ui_home"):
		_on_clear_pressed()
	if Input.is_action_pressed("加"):
		按下加()
	if Input.is_action_pressed("减"):
		按下减()
	if Input.is_action_pressed("乘"):
		按下乘()
	if Input.is_action_pressed("除"):
		按下除()
	if Input.is_action_pressed("等于"):
		等于()
	if Input.is_action_pressed("取反"):
		按下正负()
	if Input.is_action_pressed("关于"):
		_on_关于_pressed()


func 按下数字按钮(键):
	if not 已被使用:
		工作区.text = 键
		已被使用 = true
	else:
		工作区.text += 键


func _number_buttons(btn):
	if not 已被使用:
		工作区.text = btn.name
		已被使用 = true
	else:
		工作区.text += btn.name



func _on_clear_pressed():
	已被使用 = false
	历史.text = ""
	工作区.text = "0"
	小数否 = false


func 按下正负():
	var 结果 : float
	第一个数字 = 工作区.text.to_float()
	结果 = - 第一个数字
	if not 已被使用:
		历史.text = "-" + str(第一个数字)
	else:
		历史.text = str(第一个数字)
	工作区.text = str(结果)
	已被使用 = true


func 按下退格():
	if 已被使用:
		if 工作区.text.length() >= 2:
			工作区.text = 工作区.text.left(-1)
		else:
			工作区.text = "0"
			已被使用 = false


func 按下除():
	已被使用 = false
	第一个数字 = 工作区.text.to_float()
	运算符 = "/"
	历史.text = str(第一个数字) + 运算符
	小数否 = false


func 按下乘():
	已被使用 = false
	第一个数字 = 工作区.text.to_float()
	运算符 = "*"
	历史.text = str(第一个数字) + 运算符
	小数否 = false


func 按下减():
	已被使用 = false
	第一个数字 = 工作区.text.to_float()
	运算符 = "-"
	历史.text = str(第一个数字) + 运算符
	小数否 = false


func 按下加():
	已被使用 = false
	第一个数字 = 工作区.text.to_float()
	运算符 = "+"
	历史.text = str(第一个数字) + 运算符
	小数否 = false


func 按下点():
	if 小数否 == false:
		if 已被使用 == true:
			工作区.text += "."
			小数否 = true
		else:
			工作区.text = "0."
			已被使用 = true
			小数否 = true


func 等于():
	已被使用 = false
	var 结果 : float
	第二个数字 = 工作区.text.to_float()
	match 运算符:
		"+":
			结果 = 第一个数字 + 第二个数字
		"-":
			结果 = 第一个数字 - 第二个数字
		"*":
			结果 = 第一个数字 * 第二个数字
		"/":
			结果 = 第一个数字 / 第二个数字
	历史.text = str(第一个数字) + 运算符 + str(第二个数字)
	工作区.text = str(snappedf(结果, 0.0000000001))


func _on_关于_pressed():
	get_tree ().change_scene_to_file("res://关于.tscn")
