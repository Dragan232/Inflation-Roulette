package objects;

class StageObject extends FlxSprite {
	public var walkStep:Array<Float> = [0, 0];
	public var walkMovement:Array<Float> = [0, 0];
	public var randomAnimOnRespawn:Bool = false;
	public var respawnTime:Float = -1;

	public var age:Float = 0;
	public var originalOffset:FlxPoint = FlxPoint.weak(0, 0);
	public var originalPosition:FlxPoint = FlxPoint.weak(0, 0);

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		originalPosition.set(x, y);
		originalOffset = offset.clone();
	}

	public override function updateHitbox() {
		super.updateHitbox();
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
		age += elapsed;
		if (walkStep[1] != 0)
			offset.x = originalOffset.x + Math.abs(Math.sin(y / walkStep[1])) * walkMovement[0];
		if (walkStep[0] != 0)
			offset.y = originalOffset.y + Math.abs(Math.sin(x / walkStep[0])) * walkMovement[1];
		if (respawnTime > 0 && age >= respawnTime) {
			age = 0;
			if (randomAnimOnRespawn)
				animation.play(FlxG.random.getObject(animation.getNameList()), true);
			setPosition(originalPosition.x, originalPosition.y);
		}
	}
}