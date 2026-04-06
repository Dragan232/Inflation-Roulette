package backend;

/**
 * Default list of settings to be used in-game.
 */
class SaveVariables {
	public var maxFramerate:Int = 60;
	public var enableFullscreen:Bool = false;
	public var pauseOnUnfocus:Bool = false;
	public var allowPopping:Bool = true;
	public var ignoreEliminatedPlayers:Bool = false;
	public var enableDebugKeybinds:Bool = false;
	public var enablePhotosensitiveMode:Bool = false;
	public var enableForceAliasing:Bool = false;
	public var alwaysPlayMainMenuAnims:Bool = false;
	public var cameraSpeed:Float = 0.75;
	public var cameraEffectIntensity:Float = 1;
	public var enableLetterbox:Bool = true;
	public var showMusicToast:Bool = false;
	public var useBuiltInCursor:Bool = true;
	public var hideCursor:Bool = false;
	public var musicVolume:Float = 0.5;
	public var gameSoundVolume:Float = 1;
	public var uiSoundVolume:Float = 0.5;
	public var playCursorSounds:Bool = true;
	public var allowBellyGurgles:Bool = false;
	public var allowBellyCreaks:Bool = true;
	public var cacheOnGPU:Bool = true;
	public var showDebugText:Bool = false;
	public var showFramerateOnDebugText:Bool = true;
	public var showMemoryUsageOnDebugText:Bool = true;
	public var showCurrentStateOnDebugText:Bool = false;
	public var enableGLSL:Bool = true;
	public var language:String = 'en-us';

	public function new() {
	}
}

/**
 * Handles the player's game settings.
 */
class Preferences {
	/**
	 * The current list of setting variables and its values that the game is currently using.
	 */
	public static var data:SaveVariables = null;

	/**
	 * List of setting variables and its default values.
	 */
	public static var defaultData:SaveVariables = null;

	/**
	 * Saves the player's game settings and flushes them into the save directory.
	 */
	public static function savePrefs() {
		FlxG.save.bind('preferences', Utilities.getSavePath());

		for (key in Reflect.fields(data)) {
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));
		}
		FlxG.save.flush();

		trace("Preferences saved!");
		FlxG.save.bind('game', Utilities.getSavePath());
	}

	/**
	 * Loads the player's game settings from the save directory to the game.
	 */
	public static function loadPrefs() {
		if (data == null)
			data = new SaveVariables();
		if (defaultData == null)
			defaultData = new SaveVariables();

		FlxG.save.bind('preferences', Utilities.getSavePath());

		for (key in Reflect.fields(data)) {
			if (Reflect.hasField(FlxG.save.data, key)) {
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));
				// trace('loaded - $key: ${Reflect.field(FlxG.save.data, key)}');
			}
		}

		FlxG.save.bind('game', Utilities.getSavePath());

		if (Main.debugText != null) {
			Main.debugText.updateText();
		}

		#if !html5
		FlxG.autoPause = data.pauseOnUnfocus;
		#end

		FlxG.fullscreen = data.enableFullscreen;

		FlxG.mouse.useSystemCursor = !data.useBuiltInCursor;
		FlxG.mouse.visible = !data.hideCursor;

		if (data.maxFramerate > FlxG.drawFramerate) {
			FlxG.updateFramerate = data.maxFramerate;
			FlxG.drawFramerate = data.maxFramerate;
		} else {
			FlxG.drawFramerate = data.maxFramerate;
			FlxG.updateFramerate = data.maxFramerate;
		}
	}
}
