package ui;

import flixel.FlxSubState;

class SuffSubState extends FlxSubState {
	public var timePassedOnSubState:Float = 0;

	public function new() {
		super();

		camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];
	}

	public override function close() {
		Tooltip.text = '';
		super.close();
	}

	public override function update(elapsed:Float) {
		if (persistentUpdate)
			SuffState.timePassedOnState += elapsed;

		timePassedOnSubState += elapsed;

		super.update(elapsed);
	}
}
