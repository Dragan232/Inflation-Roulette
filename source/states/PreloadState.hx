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
	var loadingTexts:Array<String> = ['characters', 'gameplay', 'achievements', 'toasts', 'tooltip', 'cursor', 'splashes'];

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
		new FlxTimer().start(#if desktop 0.2 #else 0 #end, function(_) {
			switch (loadingProgress) {
				case 0:
					CharacterManager.initialize();
				case 1:
					GameplayManager.initialize();
				case 2:
					Achievements.initialize();
				case 3:
					MusicToast.initialize();
					AchievementToast.initialize();
				case 4:
					Tooltip.initialize();
				case 5:
					CustomCursorHandler.initialize();
					#if desktop
					FlxG.mouse.visible = true;
					#end
				case 6:
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
		preloadTxt.text = Language.getPhrase('preloadMenu.finished');
		FlxG.camera.fade(0xFF000000, 1, false, function() {
			SuffState.switchState(new InitStartupState());
		});
		#else
		SuffState.switchState(new InitStartupState());
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
