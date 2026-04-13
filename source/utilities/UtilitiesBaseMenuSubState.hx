package utilities;

import ui.SuffSubState;

class UtilitiesBaseMenuSubState extends SuffSubState {
	public function new() {
		super();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (Controls.justPressed('exit')) {
			leaveMenu();
		}
	}

	public function leaveMenu() {
		close();
	}
}
