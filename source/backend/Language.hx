package backend;

import flixel.system.FlxAssets;
import flixel.util.FlxSave;

class Language {
	public static final defaultLanguage:String = 'en-us';
	public static var phrases:Map<String, String> = [];
	public static var fallbackPhrases:Map<String, String> = [];

	public static function initialize() {
		phrases = fetchPhrases(Preferences.data.language);
		fallbackPhrases = fetchPhrases(defaultLanguage);

		FlxAssets.FONT_DEFAULT = Paths.font('default');
	}

	public static function fetchPhrases(langID:String = 'en-us'):Map<String, String> {
		var lePhrases:Map<String, String> = [];
		var loadedText:Array<String> = Utils.textFileToArray('lang/$langID.lang');
		for (text in loadedText) {
			// Ignore comments and empty lines
			if (text.startsWith('//') || text == '\n' && text.length <= 0)
				continue;
			var splitText:Array<String> = text.split(' = ');
			if (splitText.length <= 1)
				continue;
			lePhrases.set(splitText[0], splitText[1].replace('\\n', '\n'));
			// For some reason, Haxe does not recognize \n as a newline character when reading from a text file
		}
		return lePhrases;
	}

	public static function getPhrase(key:String, parameters:Array<Dynamic> = null, emptyIfAbsent:Bool = false):String {
		var phrase:String = phrases.get(key);
		if (phrase == null) // Fallback to the default language if the phrase does not exist in the current language
			phrase = fallbackPhrases.get(key);
		if (phrase == null) { // If the phrase does not exist in the fallback language
			if (emptyIfAbsent) // Empty if phrase is not found and emptyIfAbsent is true
				return '';
			return key;
		}
		if (parameters == null) // If no parameters are given, just
			return phrase;
		for (i in 0...parameters.length) {
			var paramKey:String = '%${i + 1}'; // Parameters are 1-indexed in the language files
			var paramValue:Dynamic = parameters[i];
			phrase = phrase.replace(paramKey, Std.string(paramValue));
		}
		return phrase;
	}
}
