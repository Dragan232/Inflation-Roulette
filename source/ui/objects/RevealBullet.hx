package ui.objects;

class RevealBullet extends FlxSprite {
	public function new(x:Float, y:Float, live:Bool = false) {
		super(x, y);

		var graphic = Paths.image('ui/bullet');
		loadGraphic(graphic, true, Std.int(graphic.width / 2), Std.int(graphic.height));
		animation.add('true', [0]);
		animation.add('false', [1]);
		animation.play(Std.string(live));
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
