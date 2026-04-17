package states;

import backend.Addons;
import backend.GameplayManager;
import backend.CharacterManager;
import backend.SplashManager;

class PreloadState extends SuffState {
	#if desktop
	var bg:FlxSprite;
	var preloadTxt:FlxText;
	#end

	var loadingProgress:Int = -1;
	var loadingTexts:Array<String> = ['characters', 'gameplay', 'music', 'achievements', 'toasts', 'tooltip', 'cursor', 'splashes'];

	override function create() {
		super.create();

		Preferences.loadPrefs();
		#if _ALLOW_ADDONS
		Addons.pushGlobalAddons();
		#end
		Language.initialize();

		#if desktop
		bg = new FlxSprite().loadGraphic(Paths.image('ui/menus/preload/loadingArt'));
		bg.alpha = 0;
		preloadTxt = new FlxText(0, 0, FlxG.width, '', 32);
		preloadTxt.alignment = CENTER;

		bg.screenCenter();
		bg.y = Std.int((FlxG.height - (bg.height + preloadTxt.height + 10)) / 2);
		preloadTxt.y = bg.y + bg.height + 10;

		add(bg);
		add(preloadTxt);
		FlxTween.tween(bg, {alpha: 1}, 0.5, {
			onComplete: function(_) {
				loadShit();
			}
		});
		#else
		loadShit();
		#end
		FlxG.mouse.visible = false;
	}

	function loadShit() {
		loadingProgress++;
		#if desktop
		preloadTxt.text = Language.getPhrase('preloadMenu.progress.' + loadingTexts[loadingProgress]);
		#end
		new FlxTimer().start(#if desktop FlxG.elapsed #else 0 #end, function(_) {
			switch (loadingProgress) {
				case 0:
					CharacterManager.initialize(#if !desktop false #end);
				case 1:
					GameplayManager.initialize();
				case 2:
					#if desktop
					var musicList = Utilities.textFileToArray('data/extras/jukebox/musicList.txt', true);
					for (music in musicList) {
						Paths.music(music);
					}
					#end
				case 3:
					Achievements.initialize();
				case 4:
					MusicToast.initialize();
					AchievementToast.initialize();
				case 5:
					Tooltip.initialize();
				case 6:
					CustomCursorHandler.initialize();
					#if desktop
					FlxG.mouse.visible = true;
					#end
				case 7:
					SplashManager.parseSplashes();
			}
			if (loadingProgress >= loadingTexts.length - 1)
				finishLoadingShit();
			else
				loadShit();
		});
	}

	function finishLoadingShit() {
		#if desktop
		/*
		SCRAM YOU FUCKER GET THE FUCK OUTTA HERE
		
		LIKE GET THE FUCK OUT OF HERE
		
		SERIOUSLY
		
		GET OUT
		
		NO
		
		SHOO
		
		OUT
		
		ARF ARF ARFARFARFARF
		
		NO
		
		No
		
		no
		
		:/
		
		ya know what whatever
		 */
		if ((Date.now().getHours() == 21 && Date.now().getMinutes() == 21)) {
			var originalDimensions:Array<Float> = [bg.width, bg.height];
			bg.loadGraphic(Paths.image('ui/menus/preload/nextUpdateLeakBroTrustMeBroImNotCappingBro'));
			bg.setGraphicSize(Std.int(originalDimensions[0]), Std.int(originalDimensions[1]));
			bg.updateHitbox();
			preloadTxt.visible = false;
			SuffState.playUISound(Paths.sound('void'));
			new FlxTimer().start(0.5, function(_) {
				FlxG.camera.fade(0xFF000000, 0, false);
				new FlxTimer().start(4.0, function(_) {
					SuffState.switchState(new InitStartupState());
				});
			});
		} else {
			preloadTxt.text = Language.getPhrase('preloadMenu.finished');
			FlxG.camera.fade(0xFF000000, 1, false, function() {
				SuffState.switchState(new InitStartupState());
			});
		}
		#else
		SuffState.switchState(new InitStartupState());
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
