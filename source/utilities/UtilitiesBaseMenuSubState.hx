package utilities;

import ui.SuffSubState;

class UtilitiesBaseMenuSubState extends SuffSubState {
	public function new() {
		super();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE) {
			leaveMenu();
		}
	}

	public function leaveMenu() {
		close();
	}
}
