# 2090s Language System

## Overview
The LanguageProcessor class is a comprehensive solution for handling language-specific settings in the Godot Engine. 
It manages language selection and font variations for UI elements based on the current language setting. 
This class is especially useful for multilingual applications and games, providing easy integration and dynamic 
language switching capabilities.

## Features
- **Language Support**: Supports a variety of languages, including those with Latin, Greek, Cyrillic, East Asian (Chinese, Korean, Japanese), and other.
- **Font Management**: Handles different font styles (regular, bold, italic/light) for each supported language.
- **Automatic Language Detection**: Defaults to the system language or falls back to English if the system language is not supported.


## Usage

### Load Language File
Create a CSV Language file and import it in Godot (Project Settings/Localizations/Add):
	
```csv
keys,de,en,fr,zh,it,ja,es,pt
menu_start,Start,Start,Début,开始,Iniziare,スタート,Inicie,Início
menu_scores,Erfolge,Scores,Succès,效益,Successi,成功事例,Éxitos,Sucessos
menu_version,Version:,Version:,Version :,版本,Versione:,バージョン,Versión:,Versão:
menu_id,ID:,ID:,ID :,身分证,ID:,IDです。,ID:,IDENTIFICAÇÃO:
scores_achievement,Bestenliste,Leaderboard,Palmarès,最佳名单,Ranking list,ランキング一覧,Listado de la clasificación,Lista de classificação
scores_name,Name,Name,Nom,命名,Nome,名称,Nombre,Nome
de,Deutsch,German,Allemand,德国,Tedesco,ジャーマン,Alemán,Alemão
en,Englisch,English,Anglais,英语,Inglese,イングリッシュ,Inglés,Inglês
fr,Französisch,French,Français,法国,Francese,フレンチ,Francés,Francês
zh,Chinesisch,Chinese,Chinois,中国,Chino,唐,Chino,Chinês
it,Italienisch,Italian,Italien,意大利语,Italiano,イタリアン,Italiano,Italiano
ja,Japanisch,Japanese,Japonais,日本人,Giapponese,やまと,Japonés,Japonês
es,Spanisch,Spanish,Espagnol,西班牙,Spagnolo,スパニッシュ,Español,Espanhol
pt,Portugiesisch,Portuguese,Portugais,葡萄牙语,Portoghese,ポルトガル語,Portugués,Português
```

### Initialization
```gdscript
var language_processor = GLanguage.LanguageProcessor.new("en") # Set language from save file or own detection
var language_processor = GLanguage.LanguageProcessor.new() # Auto-detect language with the OS.get_locale_language() function
```

- **language**: The path where the file is located or will be created.


### Methods

#### Set Language
If you want to change the language on runtime, maybe the user want to change the language

```gdscript
language_processor.set_lang(lang)
```

- **lang**:  Language code to set as the current language. ("de" or something else)
- **return**: null

#### Get Language
If you want to get the current language:
```gdscript
var current_language = language_processor.get_lang()
```

- **return**: Returns the currently set language. (i.e. "en")

#### Get Font

If you want the current fonts:
```gdscript
var fonts = language_processor.get_font()
```

- **return**: Returns an array containing the current fonts (regular, bold, italic/light).

#### Translate String

If you want to translate a string:
```gdscript
var translated_text = language_processor.translate_string(str_lang)
```

- **str_lang**: The string identifier to be translated.
- **return**: The string identifier to be translated.


#### Translate UI Tree

If you want to translate the whole scene. Best place is to add this line to the _ready function:
```gdscript
func _ready():
	language_processor.translate_tree(root_node)
```

- **root_node**: The root node of the UI tree to be translated and themed. (i.e. get_tree().get_root() )
- **return**: null


#### Add Fonts and Translate a Node

If you create a node on gdscript (Richtext or Label) you can add the translated text and the right fonts:
```gdscript
language_processor.translate(node, str_lang)
```

- **node**: The node to be updated with fonts and translation.
- **str_lang**: The string identifier for translation.
- **return**: null
