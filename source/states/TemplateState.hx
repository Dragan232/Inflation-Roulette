package states;

class TemplateState extends SuffState {
	var exiting:Bool = false;
	override function create() {
		super.create();
	}

	function exitMenu() {
		if (exiting)
			return;
		exiting = true;
		SuffState.switchState(new MainMenuState());
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) {
			SuffState.switchState(new MainMenuState());
		}
	}
}
