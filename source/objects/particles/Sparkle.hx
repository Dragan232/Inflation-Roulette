package objects.particles;

class Sparkle extends FlxSprite {
	static final variants:Array<Int> = [1, 7];
	static final framerates:Array<Int> = [18, 30];
	public var finishCallback:Sparkle->Void = null;

	public function new(x:Float = 0, y:Float = 0, finishCallback:Sparkle->Void = null) {
		super(x, y);
		frames = Paths.sparrowAtlas('game/particles/sparkle');
		animation.addByPrefix('idle', 'sparkle ${FlxG.random.int(variants[0], variants[1])}0', FlxG.random.int(framerates[0], framerates[1]), false);
		animation.play('idle', true);
		scale.set(3, 3);
		updateHitbox();
		offset.x += width / 2;
		offset.y += height / 2;
		this.finishCallback = finishCallback;
		animation.onFinish.add(function(_) {
			if (finishCallback != null)
				finishCallback(this);
			else
				this.destroy();
		});
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
