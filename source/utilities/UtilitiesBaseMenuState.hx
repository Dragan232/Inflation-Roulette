package utilities;

import states.MainMenuState;
import flixel.addons.display.FlxGridOverlay;
import ui.objects.SuffIconButton;
import utilities.states.UtilitiesMainMenuState;

class UtilitiesBaseMenuState extends SuffState {
	public var bg:FlxBackdrop;
	public var exitButton:SuffIconButton;
	var musicList:Array<String> = [];
	public static var loadedPath:String = null;
	public var escapeToLeave:Bool = true;
	override function create() {
		musicList = Utilities.textFileToArray('data/utilities/musicList.txt');

		super.create();

		bg = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, 0xFFC0C0C0, 0xFF909090));
		bg.velocity.set(32, 32);
		add(bg);

		exitButton = new SuffIconButton(10, 10, 'buttons/exit', null, 2);
		exitButton.x = FlxG.width - exitButton.width - 10;
		exitButton.y = FlxG.height - exitButton.height - 10;
		exitButton.onClick = function() {
			leaveMenu();
		}
		add(exitButton);
	}

	public function playRandomMusic() {
		SuffState.playMusic(FlxG.random.getObject(musicList), 1, true);
		FlxG.sound.music.time = FlxG.sound.music.loopTime;
		FlxG.sound.music.onComplete = function() {
			playRandomMusic();
		};
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (escapeToLeave && FlxG.keys.justPressed.ESCAPE) {
			leaveMenu();
		}
	}

	public function leaveMenu() {
		UtilitiesMainMenuState.initialized = false;
		SuffState.playMusic('mainMenu');
		SuffState.switchState(new MainMenuState());
	}
}
