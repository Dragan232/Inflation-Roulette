package utilities.objects;

class FrameTimeBar extends FlxSpriteGroup {
	public function new(x:Float = 0, y:Float = 0, framerate:Int = 24) {
        super();

		updateFramerate(framerate);

		this.x = x;
		this.y = y;
	}

	public function updateFramerate(framerate:Int) {
		clear();

		var leWidth:Int = FlxG.width * 4;

		for (i in 0...Math.ceil(leWidth / 12)) {
			var what:FlxSprite = new FlxSprite();
			var height:Int = 10;
			if (i % 2 == 0) {
				height = 14;
			}
			if (Std.int(framerate / 4) != 0 && i % Std.int(framerate / 4) == 0) {
				height = 18;
			}
			if (Std.int(framerate / 2) != 0 && i % Std.int(framerate / 2) == 0) {
				height = 20;
			}
			if (i % framerate == 0) {
				height = 25;
			}
			what.makeGraphic(2, height, 0xFF606060);
			what.x = 12 * i + (12 - what.width) / 2 + 1;
			what.y = 20 + 25 - what.height;

			if (i % framerate == 0) {
				var txt:FlxText = new FlxText(0, 0, 0, '' + Std.int(i / framerate), 16);
				txt.x = what.x + (what.width - txt.width) / 2;
				txt.color = 0xFF606060;
				add(txt);
			}
			add(what);
		}
		var bottomLine:FlxSprite = new FlxSprite(0, 20 + 25 - 2).makeGraphic(leWidth, 2, 0xFF606060);
		add(bottomLine);
	}
}
