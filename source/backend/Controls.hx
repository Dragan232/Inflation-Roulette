package backend;

import flixel.input.keyboard.FlxKey;

class Controls {
	public static var keybinds:Map<String, Array<FlxKey>>;

	public static function justPressed(key:String) {
		return FlxG.keys.anyJustPressed(keybinds[key]) == true;
	}
	public static function pressed(key:String) {
		return FlxG.keys.anyPressed(keybinds[key]) == true;
	}
	public static function justReleased(key:String) {
		return FlxG.keys.anyJustReleased(keybinds[key]) == true;
	}

	public static function reloadKeybinds() {
		keybinds = Preferences.data.keybinds;
	}
}