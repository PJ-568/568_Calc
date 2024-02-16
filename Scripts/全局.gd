extends Node


const CONFIG_PATH := "user://settings.cfg"

#var 应该使用字体 := false


func _ready():
	#根据语言切换主题(读取设置并更改语言())
	读取设置并更改语言()
	改变初始窗口大小()


func 切换语言(index):
	if index == 0:
		return 根据系统语言切换语言()
	elif index == 1:
		TranslationServer.set_locale("zh")
	elif index == 2:
		TranslationServer.set_locale("zht")
	elif index == 3:
		TranslationServer.set_locale("en")
	elif index == 4:
		TranslationServer.set_locale("jp")
	elif index == 5:
		TranslationServer.set_locale("es")
	else:
		push_error("切换语言时，选项“%d”不存在！" % index)
		TranslationServer.set_locale("en")
	return index


func 保存设置(index):
	var file := ConfigFile.new()
	file.set_value("General", "Language", index)
	var error := file.save(CONFIG_PATH)
	if error != OK:
		push_error("Failed to save config: %d" % error)


func 切换并保存(index):
	return 保存设置(切换语言(index))


func 读取设置():
	var file := ConfigFile.new()
	if FileAccess.file_exists(CONFIG_PATH):
		var error := file.load(CONFIG_PATH)
		if error == OK:
			return file.get_value("General", "Language", 0)
		else:
			push_warning("Failed to load config: %d", error)
	return 初始化语言设置()


func 读取设置并更改语言():
	return 切换语言(读取设置())


func 根据系统语言切换语言():
	var locale := OS.get_locale()
	if locale == "zh_CN":
		切换语言(1)
	elif locale == "zh_TW":
		切换语言(2)
	elif locale == "en":
		切换语言(3)
	elif locale == "jp":
		切换语言(4)
	elif locale == "es":
		切换语言(5)
	else:
		切换语言(3)
	return 0


func 初始化语言设置():
	return 切换并保存(0)


#func 根据语言切换主题(index):
	#if index == 1 or index == 3 or index == 5:
		#应该使用字体 = true
		##propagate_call(“update”)
	#else:
		#应该使用字体 = false


func 改变初始窗口大小():
	# 获取系统类型
	var sys_name := OS.get_name()
	# 根据系统类型判断是否调整窗口DPI
	if sys_name == "Windows" or sys_name == "macOS" or sys_name == "Linux" or sys_name == "BSD":
		get_viewport().size = Vector2(DisplayServer.screen_get_dpi() * 3.5, DisplayServer.screen_get_dpi() * 6.2)
