package substates;

import ui.objects.SuffBooleanOption;
import ui.objects.SuffIconButton;
import ui.objects.SuffSliderOption;
import flixel.group.FlxSpriteContainer;

class ControlsOptionsSubState extends SuffSubState {
	var bg:FlxSprite;
	var controlsGroup:FlxSpriteContainer = new FlxSpriteContainer();
	var scrollBar:FlxSprite;
	public function new() {
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.75;
		add(bg);

		add(controlsGroup);

		generateOptions();

		var exitButton = new SuffIconButton(20, 20, 'buttons/exit', null, 2);
		exitButton.x = FlxG.width - exitButton.width - 20;
		exitButton.onClick = function() {
			exitOptionsMenu();
		};
		add(exitButton);

		camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];
	}

	function generateOptions() {
		controlsGroup.clear();
	}

	function exitOptionsMenu() {
		Preferences.savePrefs();
		Preferences.loadPrefs();
		close();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (Controls.justPressed('exit')) {
			exitOptionsMenu();
		}
	}
}
