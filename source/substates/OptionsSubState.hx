package substates;

import ui.objects.SuffBooleanOption;
import ui.objects.SuffIconButton;
import ui.objects.SuffSliderOption;

class OptionsSubState extends SuffSubState {
	public static var notInGame:Bool = true;

	var bg:FlxSprite;
	var bg2:FlxSprite;
	var scrollBar:FlxSprite;
	var exitButton:SuffIconButton;

	var optionsGroup:FlxSpriteGroup = new FlxSpriteGroup();

	static final optionsXPadding:Float = 32;
	static final optionsYPadding:Float = 32;
	static final scrollBarWidth:Int = 30;

	var optionsMaxWidth:Float = 0;
	var optionsY:Float = 0;
	var optionsScrollUpperLimit:Float = 0;
	var optionsScrollLowerLimit:Float = 0;
	var scrollBarTween:FlxTween;

	var optionsScroll:Float = 0;
	var optionsScrollLerped:Float = 0;

	static final scrollLerpFactor:Float = 10;

	var touchedMusicOption:Bool = false;

	public function new() {
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.75;
		add(bg);

		bg2 = new FlxSprite();
		add(bg2);

		if (notInGame) {
			SuffState.playMusic('options');
		}

		scrollBar = new FlxSprite();
		add(scrollBar);

		optionsY = optionsYPadding;
		optionsScrollUpperLimit = optionsY;
		optionsScrollLowerLimit = optionsY;

		add(optionsGroup);
		optionsGroup.camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];
		generateOptions();

		bg2.makeGraphic(Std.int(optionsXPadding + optionsMaxWidth + optionsXPadding + scrollBarWidth), FlxG.height, FlxColor.BLACK);
		bg2.alpha = 0.375;

		scrollBar.makeGraphic(scrollBarWidth, Std.int(FlxG.height * (FlxG.height / (Math.abs(optionsScrollLowerLimit) + FlxG.height))), FlxColor.WHITE);
		scrollBar.x = bg2.width - scrollBar.width;
		updateScrollBar();

		exitButton = new SuffIconButton(20, 20, 'buttons/exit', null, 2);
		exitButton.x = FlxG.width - exitButton.width - 20;
		exitButton.onClick = function() {
			exitOptionsMenu();
		};
		add(exitButton);

		camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];
	}

	function generateOptions() {
		optionsGroup.clear();

		createHeading('gameplay');

		createBooleanOption("ignoreEliminatedPlayers",
			function(value:Bool) {
				Preferences.data.ignoreEliminatedPlayers = value;
			}, Preferences.data.ignoreEliminatedPlayers);

		createHeading('preferences');

		createBooleanOption('enablePopping',
			function(value:Bool) {
				Preferences.data.enablePopping = value;
			}, Preferences.data.enablePopping);

		createBooleanOption("enableBellyGurgles", function(value:Bool) {
			Preferences.data.enableBellyGurgles = value;
		}, Preferences.data.enableBellyGurgles);

		createBooleanOption("enableBellyCreaks", function(value:Bool) {
			Preferences.data.enableBellyCreaks = value;
		}, Preferences.data.enableBellyCreaks);

		// GRAPHICS SETTINGS
		createHeading('visuals');

		#if desktop
		createBooleanOption('enableFullscreen', function(value:Bool) {
			Preferences.data.enableFullscreen = value;
		}, Preferences.data.enableFullscreen);
		#end

		createBooleanOption('enableForceAliasing', function(value:Bool) {
			Preferences.data.enableForceAliasing = value;
		}, Preferences.data.enableForceAliasing);

		createBooleanOption('enableGLSL', function(value:Bool) {
			Preferences.data.enableGLSL = value;
		}, Preferences.data.enableGLSL);

		createBooleanOption('alwaysPlayMainMenuAnims', function(value:Bool) {
			Preferences.data.alwaysPlayMainMenuAnims = value;
		}, Preferences.data.alwaysPlayMainMenuAnims);

		createBooleanOption('showMusicToast',
			function(value:Bool) {
				Preferences.data.showMusicToast = value;
			}, Preferences.data.showMusicToast);

		createBooleanOption('enableLetterbox',
			function(value:Bool) {
				Preferences.data.enableLetterbox = value;
			}, Preferences.data.enableLetterbox);

		// AUDIO SETTINGS
		createHeading('audio');

		createSliderOption('musicVolume', function(value:Float) {
			Preferences.data.musicVolume = value;
			if (notInGame)
				FlxG.sound.music.volume = Preferences.data.musicVolume;
		}, 0.0, 1.0, 0.05, function(value:Float) {
			return Math.round(value * 100) + '%';
		}, Preferences.data.musicVolume);

		createSliderOption('gameSoundVolume', function(value:Float) {
			Preferences.data.gameSoundVolume = value;
			SuffState.playSound(Paths.soundRandom('game/weapon', 1, 3));
		}, 0.0, 1.0, 0.05, function(value:Float) {
			return Math.round(value * 100) + '%';
		}, Preferences.data.gameSoundVolume);

		createSliderOption('uiSoundVolume', function(value:Float) {
			Preferences.data.uiSoundVolume = value;
			SuffState.playUISound(Paths.soundRandom('game/weapon', 1, 3));
		}, 0.0, 1.0, 0.05, function(value:Float) {
			return Math.round(value * 100) + '%';
		}, Preferences.data.uiSoundVolume);

		createHeading('accessibility');

		createBooleanOption('enablePhotosensitiveMode', function(value:Bool) {
				Preferences.data.enablePhotosensitiveMode = value;
		}, Preferences.data.enablePhotosensitiveMode);

		createSliderOption('cameraSpeed', function(value:Float) {
			Preferences.data.cameraSpeed = value;
			PauseSubState.usedFollowLerp = 60 / FlxG.updateFramerate * 0.1 * Preferences.data.cameraSpeed;
		}, 0.25, 2, 0.05, function(value:Float) {
			return Math.round(value * 100) + '%';
		}, Preferences.data.cameraSpeed);

		createSliderOption('cameraEffectIntensity', function(value:Float) {
			Preferences.data.cameraEffectIntensity = value;
		}, 0, 2, 0.05, function(value:Float) {
			return Math.round(value * 100) + '%';
		}, Preferences.data.cameraEffectIntensity);

		createHeading('cursor');

		createBooleanOption('useBuiltInCursor', function(value:Bool) {
			Preferences.data.useBuiltInCursor = value;
			FlxG.mouse.useSystemCursor = !value;
		}, Preferences.data.useBuiltInCursor);

		#if html5
		createBooleanOption('hideCursor', function(value:Bool) {
			Preferences.data.hideCursor = value;
			FlxG.mouse.visible = !value;
		}, Preferences.data.hideCursor);
		#end

		createBooleanOption('playCursorSounds', function(value:Bool) {
			Preferences.data.playCursorSounds = value;
		}, Preferences.data.playCursorSounds);

		// TECHNICAL SETTINGS
		createHeading('technical');

		createSliderOption('maxFramerate', function(value:Float) {
			Preferences.data.maxFramerate = Math.round(value);
			PauseSubState.usedFollowLerp = 60 / FlxG.updateFramerate * 0.1 * Preferences.data.cameraSpeed;
		}, 30, 300, 10, function(value:Float) {
			return '' + Math.round(value);
		}, Preferences.data.maxFramerate);

		#if !html5
		createBooleanOption('pauseOnUnfocus', function(value:Bool) {
			Preferences.data.pauseOnUnfocus = value;
		}, Preferences.data.pauseOnUnfocus);
		#end

		#if (openfl && !html5)
		createBooleanOption("cacheOnGPU",
			function(value:Bool) {
				Preferences.data.cacheOnGPU = value;
			}, Preferences.data.cacheOnGPU);
		#end

		createBooleanOption("enableDebugKeybinds", function(value:Bool) {
			Preferences.data.enableDebugKeybinds = value;
		}, Preferences.data.enableDebugKeybinds);

		// DEBUG TEXT SETTINGS
		createHeading('debugText');

		createBooleanOption('showDebugText', function(value:Bool) {
			Preferences.data.showDebugText = value;
			Main.debugText.updateText();
		}, Preferences.data.showDebugText);

		createBooleanOption('showFramerateOnDebugText', function(value:Bool) {
			Preferences.data.showFramerateOnDebugText = value;
			Main.debugText.updateText();
		}, Preferences.data.showFramerateOnDebugText);

		#if (openfl && !html5)
		createBooleanOption('showMemoryUsageOnDebugText', function(value:Bool) {
			Preferences.data.showMemoryUsageOnDebugText = value;
			Main.debugText.updateText();
		}, Preferences.data.showMemoryUsageOnDebugText);
		#end

		createBooleanOption('showCurrentStateOnDebugText', function(value:Bool) {
			Preferences.data.showCurrentStateOnDebugText = value;
			Main.debugText.updateText();
		}, Preferences.data.showCurrentStateOnDebugText);

		var lastItem = optionsGroup.members[optionsGroup.members.length - 1];
		optionsScrollLowerLimit = -(lastItem.y + lastItem.height + optionsYPadding);
		if (optionsScrollLowerLimit < -FlxG.height) {
			optionsScrollLowerLimit += FlxG.height;
		}
	}

	function createHeading(name:String) {
		if (optionsGroup.members.length > 0)
			optionsY += 32;
		var text:FlxText = new FlxText(32, optionsY, 0, Language.getPhrase('optionsMenu.heading.$name'));
		text.setFormat(Paths.font('default'), 32, FlxColor.WHITE, CENTER);
		optionsGroup.add(text);
		optionsY += 48;

		if (text.x + text.width - optionsXPadding > optionsMaxWidth) {
			optionsMaxWidth = text.x + text.width - optionsXPadding;
		}
	}

	function createBooleanOption(ID:String, callback:Bool->Void, defaultValue:Bool) {
		var text:FlxText = new FlxText(optionsXPadding, optionsY, 0, Language.getPhrase('option.${ID}.name'));
		text.setFormat(Paths.font('default'), 48, FlxColor.WHITE, CENTER);
		optionsGroup.add(text);

		var option:SuffBooleanOption = new SuffBooleanOption(text.x + text.width + 16, optionsY, callback, defaultValue);
		text.y = option.y + (option.height - text.height) / 2;
		option.camera = this.camera;
		option.tooltipText = Language.getPhrase('option.${ID}.description');
		optionsGroup.add(option);

		optionsY += option.height + 16;
		if (option.x + option.width - optionsXPadding > optionsMaxWidth) {
			optionsMaxWidth = option.x + option.width - optionsXPadding;
		}
	}

	function createSliderOption(ID:String, callback:Float->Void, rangeMin:Float, rangeMax:Float, step:Float, displayFunction:Float->String, defaultValue:Float) {
		var text:FlxText = new FlxText(optionsXPadding, optionsY, 0, Language.getPhrase('option.${ID}.name'));
		text.setFormat(Paths.font('default'), 48, FlxColor.WHITE, CENTER);
		optionsGroup.add(text);

		var option:SuffSliderOption = new SuffSliderOption(text.x + text.width + 16, optionsY, callback, rangeMin, rangeMax, step, displayFunction,
			defaultValue);
		text.y = option.y + (option.height - text.height) / 2;
		option.camera = this.camera;
		option.tooltipText = Language.getPhrase('option.${ID}.description');
		optionsGroup.add(option);

		optionsY += option.height + 16;
		if (option.x + option.width - optionsXPadding > optionsMaxWidth) {
			optionsMaxWidth = option.x + option.width - optionsXPadding;
		}
	}

	function updateScrollBar() {
		scrollBar.alpha = 0.375;

		if (scrollBarTween != null)
			scrollBarTween.cancel();
		scrollBarTween = FlxTween.tween(scrollBar, {alpha: 0.15}, 4, {
			startDelay: 1
		});
	}

	function exitOptionsMenu() {
		Preferences.savePrefs();
		Preferences.loadPrefs();
		if (touchedMusicOption) {
			PauseSubState.resetMusic = true;
		}
		Tooltip.text = '';
		close();
		if (notInGame) {
			SuffState.playMusic('mainMenu');
		}
	}

	function boundOptionMenuScroll() {
		if (optionsScroll > 0) {
			optionsScroll = 0;
		} else if (optionsScroll < optionsScrollLowerLimit) {
			optionsScroll = optionsScrollLowerLimit;
		}
	}

	var allowMouseScrolling:Bool = true;

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			exitOptionsMenu();
		}
		if (FlxG.mouse.wheel != 0) {
			optionsScroll += FlxG.mouse.wheel * 128;
			boundOptionMenuScroll();
			updateScrollBar();
		}
		if (allowMouseScrolling && FlxG.mouse.pressed && FlxG.mouse.getPositionInCameraView(this.camera).x >= scrollBar.x) {
			optionsScroll = optionsScroll - (FlxG.mouse.deltaScreenY) * (FlxG.height / scrollBar.height);
			boundOptionMenuScroll();
			updateScrollBar();
		}

		optionsScrollLerped = FlxMath.lerp(optionsScrollLerped, optionsScroll, elapsed * scrollLerpFactor);
		optionsGroup.y = optionsScrollLerped;
		scrollBar.y = optionsScrollLerped / optionsScrollLowerLimit * (FlxG.height - scrollBar.height);

		allowMouseScrolling = true;
		for (opt in optionsGroup) {
			if (Std.isOfType(opt, SuffBooleanOption)) {
				var option:SuffBooleanOption = cast opt;
				if (option.hovered) {
					allowMouseScrolling = false;
				}
			} else if (Std.isOfType(opt, SuffSliderOption)) {
				var option:SuffSliderOption = cast opt;
				if (option.pressed) {
					allowMouseScrolling = false;
				}
			}
		}
	}
}
