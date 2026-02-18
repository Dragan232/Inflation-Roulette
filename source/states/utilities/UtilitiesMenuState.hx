package states.utilities;

import states.utilities.*;

class UtilitiesMenuState extends SuffState {
	override function create() {
		super.create();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			SuffState.switchState(new MainMenuState());
		}
	}
}
