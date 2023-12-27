extends Node

# Class LanguageProcessor handles language settings, font variations for UI elements.
class LanguageProcessor:
	var _cur_language : String # Current language setting
	var cur_font_regular : Object # Current regular font object
	var cur_font_bold : Object # Current bold font object
	var cur_font_italic_light : Object # Current italic/light font object
	# Lists of language codes categorized by script type
	var latin_greek_cyrillic : Array = [# Languages using Latin, Greek, or Cyrillic font
											"al", "ar", "at", "au", "ba", "be", "bg", "bo", "br", "by", "ca", "ch", "cl", "co", "cr", "cu", "cz", "de", "dk", 
											"do", "ec", "ee", "es", "fi", "fr", "gb", "gr", "gt", "hn", "hr", "hu", "ie", "is", "it", "kg", "kz", "lt", "lu", 
											"lv", "mk", "mn", "mt", "mx", "ni", "nl", "no", "nz", "pa", "pe", "pl", "pt", "py", "ro", "rs", "ru", "se", "si", 
											"sk", "sv", "tj", "tr", "ua", "us", "uy", "ve"
										]
	var ko_zh_ja : Array = ["zh", "ko", "ja"] # East Asian languages (Chinese, Korean, Japanese)
	var myanmar : Array = ["my"] # Myanmar language
	var ar_he : Array = [ # languages (Arabic, Hebrew)
							"af", "am", "bm", "ha", "ig", "rn", "mg", "ny", "rw", "sn", "so", "ss", "st", "sw", "tn", "ts", 
							"ve", "wo", "xh", "yo", "zu", "ar", "he"
						]
	var tibetan : Array = ["bo"] # Tibetan language
	var thai : Array = ["th"] # Thai language
	var hindi : Array = ["hi", "hif"] # Hindi languages
	# Dictionary mapping language regions to their respective fonts
	var list_font : Dictionary = {
										"latin": {
													"regular": "res://addons/language_system/fonts/NotoSerif-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/NotoSerif-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerif-Italic.ttf"
												},
										"asia": {
													"regular": "res://addons/language_system/fonts/NotoSerifSC-Regular.otf", 
													"bold": "res://addons/language_system/fonts/NotoSerifSC-Bold.otf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerifSC-Light.otf"
												},
										"myanmar": {
													"regular": "res://addons/language_system/fonts/NotoSerifMyanmar-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/NotoSerifMyanmar-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerifMyanmar-Light.ttf"
												},
										"arabic_hebraic": {
													"regular": "res://addons/language_system/fonts/Rubik-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/Rubik-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/Rubik-Italic.ttf"
												},
										"tibet": {
													"regular": "res://addons/language_system/fonts/NotoSerifTibetan-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/NotoSerifTibetan-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerifTibetan-Light.ttf"
												},
										"thai": {
													"regular": "res://addons/language_system/fonts/NotoSerifThai-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/NotoSerifThai-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerifThai-Light.ttf"
												},
										"hindi": {
													"regular": "res://addons/language_system/fonts/NotoSerifBengali-Regular.ttf", 
													"bold": "res://addons/language_system/fonts/NotoSerifBengali-Bold.ttf", 
													"italic_or_light": "res://addons/language_system/fonts/NotoSerifBengali-Light.ttf"
												},
										}
	var _region : String # The script region of the current language
	
	# Constructor, initializes the processor with a default or specified language
	func _init(language = ""):
		# Determine the system language, used the language in the variable language or set to English if unsupported
		if language == "":
			var system_language : String = OS.get_locale_language()
			# Check if system language is supported, otherwise default to English
			var lang_list = latin_greek_cyrillic + ko_zh_ja + myanmar + ar_he + tibetan + thai + hindi
			if !lang_list.has(system_language):
				system_language = "en"
			self.set_lang(system_language)
		else:
			self.set_lang(language)
		return 
		
	# Sets the region based on the current language
	func set_region():
		if self._cur_language in latin_greek_cyrillic:
			self._region = "latin"
		elif self._cur_language in ko_zh_ja:
			self._region = "asia"
		elif self._cur_language in myanmar:
			self._region = "myanmar"
		elif self._cur_language in ar_he:
			self._region = "arabic_hebraic"
		elif self._cur_language in tibetan:
			self._region = "tibet"
		elif self._cur_language in thai:
			self._region = "thai"
		elif self._cur_language in hindi:
			self._region = "hindi"
		return
	
	# Sets the font based on the current region
	func set_font():
		# Load and set fonts for regular, bold, and italic/light based on the current region
		self.cur_font_regular = FontVariation.new()
		self.cur_font_bold = FontVariation.new()
		self.cur_font_italic_light = FontVariation.new()
		self.cur_font_regular.set_base_font(load(self.list_font[self._region]["regular"]))
		self.cur_font_bold.set_base_font(load(self.list_font[self._region]["bold"]))
		self.cur_font_italic_light.set_base_font(load(self.list_font[self._region]["italic_or_light"]))
		
	# Returns the currently set fonts
	func get_font():
		return [self.cur_font_regular, self.cur_font_bold, self.cur_font_italic_light]
		
	# Sets the current language and updates region and font settings	
	func set_lang(lang):
		TranslationServer.set_locale(lang)
		self._cur_language = lang
		self.set_region()
		self.set_font()
		
	# Returns the current language setting
	func get_lang():
		return self._cur_language
		
	# Applies the current fonts to a given node
	func set_node_font(node):
		node.set("custom_fonts/normal_font",self.cur_font_regular)
		node.set("custom_fonts/bold_font",self.cur_font_bold)
		node.set("custom_fonts/italics_font",self.cur_font_italic_light)
		
	# Translates a given string using the current language setting
	func translate_string(str_lang):
		var translate_word = TranslationServer.translate(str_lang)
		return translate_word
		
	# Recursively translates text and applies fonts of all UI elements in a node tree
	func translate_tree(node):
		for N in node.get_children():
			self.set_node_font(N)
			if N.get_child_count() > 0:
				if N.get_class() == "RichTextLabel":
					if N.get_name() != "rtx_privacy":
						#N.set_theme(self._set_theme)
						N.clear()
						N.append_bbcode(TranslationServer.translate(N.get_name()))
				else:
					self.translate_tree(N)
			else:
				if N.get_class() == "Label":
					#N.set_theme(self._set_theme)
					N.text = TranslationServer.translate(N.get_name())
	
	# Translates a specific node based on the given string
	func translate(node, str_lang):
		self.set_node_font(node)
		if node.get_class() == "RichTextLabel":
			#node.set_theme(self._set_theme)
			node.clear()
			node.add_text(TranslationServer.translate(str_lang))
		else:
			#node.set_theme(self._set_theme)
			node.text = tr(str_lang)
