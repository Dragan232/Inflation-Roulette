package substates;

import ui.objects.SuffIconButton;
import flixel.group.FlxSpriteContainer;

class ControlsOptionsSubState extends SuffSubState {
	var bg:FlxSprite;
	var controlsGroup:FlxSpriteContainer = new FlxSpriteContainer();
	public static var keyBindButtons:Array<Map<String, SuffButton>> = [];
	var scrollBar:FlxSprite;
	public function new() {
		super();

		bg = new FlxSprite().loadGraphic(Paths.image('ui/menus/options/controls/bg'));
		bg.color = 0x303030;
		add(bg);

		add(controlsGroup);

		generateOptions();

		var exitButton = new SuffIconButton(20, 20, 'buttons/exit', null, 2);
		exitButton.x = FlxG.width - exitButton.width - 60;
		exitButton.onClick = function() {
			exitOptionsMenu();
		};
		add(exitButton);
		
		var scrollBarBG = new FlxSprite().makeGraphic(30, FlxG.height, 0xFFFFFFFF);
		scrollBarBG.x = FlxG.width - scrollBarBG.width;
		scrollBarBG.alpha = 0.125;
		add(scrollBarBG);

		scrollBar = new FlxSprite(scrollBarBG.x, scrollBarBG.y).makeGraphic(Std.int(scrollBarBG.width), Std.int(FlxG.height * FlxG.height / controlsGroup.height), 0xFFFFFFFF);
		scrollBar.alpha = 0.25;
		scrollBar.active = false;
		add(scrollBar);

		camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];
	}

	function generateOptions() {
		controlsGroup.clear();
		keyBindButtons = [
			new Map<String, SuffButton>(),
			new Map<String, SuffButton>()
		];
		addHeading('gameplay');
		addKeybind('shoot');
		addKeybind('exit');
		addKeybind('camera');
		addKeybind('skill1');
		addKeybind('skill2');
		addKeybind('skill3');
		// Unused
		// addKeybind('skill4');
		addKeybind('pause');

		addHeading('ui');
		addKeybind('up');
		addKeybind('left');
		addKeybind('down');
		addKeybind('right');

		addHeading('debug');
		addKeybind('debug1');
		addKeybind('debug2');
		// Unused
		// addKeybind('debug3');
		// addKeybind('debug4');
		// addKeybind('debug5');

		if (controlsGroup.height > FlxG.height) {
			controlMenuMax = controlsGroup.height - FlxG.height + 64;
		}
	}

	var controlsY:Float = 32;
	var controlMenuMax:Float = 0;
	var controlMenuY:Float = 0;

	function addHeading(heading:String) {
		var text:FlxText = new FlxText(0, controlsY, 960, Language.getPhrase('option.controls.$heading'), 64);
		text.alignment = CENTER;
		text.x = (FlxG.width - text.width) / 2;
		controlsGroup.add(text);
		controlsY += text.height + 32;
	}

	function addKeybind(keybind:String) {
		var keybindHeading:FlxText = new FlxText(0, controlsY, 320, Language.getPhrase('option.controls.keybind.$keybind'), 32);
		keybindHeading.alignment = CENTER;
		keybindHeading.x = (FlxG.width - 960) / 2;
		controlsGroup.add(keybindHeading);
		var keyX = keybindHeading.x + keybindHeading.width;
		for (i in 0...2) {
			var what = '';
			var key:Null<FlxKey> = Preferences.data.keybinds.get(keybind)[i];
			if (key == null) key = FlxKey.NONE;
			if (key != null) what = Utilities.formatKey(key);
			var keybindButton:SuffButton = new SuffButton(keyX, 0, what, 320 - 64, 64, true);
			keybindButton.x += 32;
			keybindButton.y = controlsY + (keybindHeading.height - keybindButton.height) / 2;
			keybindButton.onClick = function () {
				openSubState(new BindingKeyPrompt(keybind, i));
			}
			keyBindButtons[i].set(keybind, keybindButton);
			keyX += 320;
			controlsGroup.add(keybindButton);
		}
		controlsY += keybindHeading.height + 32;
	}

	function exitOptionsMenu() {
		Preferences.savePrefs();
		Preferences.loadPrefs();
		close();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		if (FlxG.mouse.wheel != 0) {
			controlMenuY = FlxMath.bound(controlMenuY - FlxG.mouse.wheel * 64, 0, controlMenuMax);
			scrollBar.y = controlMenuY / controlMenuMax * (FlxG.height - scrollBar.height);
		} else if (FlxG.mouse.justPressed && FlxG.mouse.getPositionInCameraView(this.camera).x >= scrollBar.x) {
			scrollBar.active = true;
		}
		if (scrollBar.active) {
			var deltaY = FlxG.mouse.deltaScreenY;
			scrollBar.y = FlxMath.bound(scrollBar.y + deltaY, 0, FlxG.height - scrollBar.height);
			controlMenuY = scrollBar.y / (FlxG.height - scrollBar.height) * controlMenuMax;
		}
		if (FlxG.mouse.justReleased)
			scrollBar.active = false;
		controlsGroup.y = FlxMath.lerp(controlsGroup.y, -controlMenuY, elapsed * 8);

		if (Controls.justPressed('exit')) {
			exitOptionsMenu();
		}
	}
}
