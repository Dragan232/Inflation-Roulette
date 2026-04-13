package backend;

/**
 * Default list of settings to be used in-game.
 */
class SaveVariables {
	public var maxFramerate:Int = 60;
	public var enableFullscreen:Bool = false;
	public var pauseOnUnfocus:Bool = false;
	public var enablePopping:Bool = true;
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
	public var musicVolume:Float = 0.25;
	public var gameSoundVolume:Float = 1;
	public var uiSoundVolume:Float = 0.5;
	public var playCursorSounds:Bool = true;
	public var enableBellyGurgles:Bool = false;
	public var enableBellyCreaks:Bool = true;
	public var cacheOnGPU:Bool = true;
	public var showDebugText:Bool = false;
	public var showFramerateOnDebugText:Bool = true;
	public var showMemoryUsageOnDebugText:Bool = true;
	public var showCurrentStateOnDebugText:Bool = false;
	public var enableGLSL:Bool = true;
	public var language:String = 'en-us';

	public var keybinds:Map<String, Array<FlxKey>> = [
		'shoot' => [ENTER, Z],
		'exit' => [ESCAPE, X],
		'camera' => [BACKSLASH, C],
		'skill1' => [ONE],
		'skill2' => [TWO],
		'skill3' => [THREE],
		'skill4' => [FOUR],
		'pause' => [ESCAPE],
		'up' => [FlxKey.UP, W],
		'left' => [FlxKey.LEFT, A],
		'down' => [FlxKey.DOWN, S],
		'right' => [FlxKey.RIGHT, D],
		'showCursor' => [G],
		'debug1' => [N],
		'debug2' => [M]
	];

	public function new() {
	}
}

/**
 * Handles the player's game settings.
 */
class Preferences {
	public static var data:SaveVariables = null;
	public static var defaultData:SaveVariables = null;

	public static final manuallyProcessedKeys = ['keybinds'];

	public static function savePrefs() {
		FlxG.save.bind('preferences', Utilities.getSavePath());

		for (key in Reflect.fields(data)) {
			if (manuallyProcessedKeys.contains(key)) continue;
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
			if (manuallyProcessedKeys.contains(key) || !Reflect.hasField(FlxG.save.data, key)) continue;
			Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));
		}

		FlxG.save.bind('controls', Utilities.getSavePath());
		if (FlxG.save.data.keybinds != null) {
			var savedMap:Map<String, Array<FlxKey>> = FlxG.save.data.keybinds;
			for (name => value in savedMap)
				data.keybinds.set(name, value);
		} else {
			FlxG.save.data.keybinds = new Map<String, Array<FlxKey>>();
		}
		Controls.reloadKeybinds();

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
