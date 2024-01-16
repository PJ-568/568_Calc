extends Node


const CONFIG_PATH = "user://settings.cfg"


func _ready():
	读取设置()


func 切换语言(index):
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
	else:
		push_error("切换语言时，选项“%d”不存在！" % index)
		TranslationServer.set_locale("en")
	return index


func 保存设置(index):
	var file = ConfigFile.new()
	file.set_value("General", "Language", index)
	var error = file.save(CONFIG_PATH)
	if error != OK:
		push_error("Failed to save config: %d" % error)


func 切换并保存(index):
	保存设置(切换语言(index))


func 读取设置():
	var file = ConfigFile.new()
	if FileAccess.file_exists(CONFIG_PATH):
		var error = file.load(CONFIG_PATH)
		if error == OK:
			return 切换语言(file.get_value("General", "Language", 0))
		else:
			push_warning("Failed to load config: %d", error)
			return 切换语言(0)
	else:
		var locale = OS.get_locale()
		if locale == "zh_CN":
			return 切换语言(0)
		elif locale == "zh_TW":
			return 切换语言(1)
		elif locale == "en":
			return 切换语言(2)
		elif locale == "jp":
			return 切换语言(3)
		elif locale == "es":
			return 切换语言(4)
