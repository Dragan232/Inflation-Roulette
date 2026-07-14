package objects.particles;

class HoseboundChain extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0, playerIndex:Int = 0) {
		super(x, y);
		loadGraphic(Paths.image('game/particles/hoseboundChain'));
		this.color = Constants.PLAYER_COLORS[playerIndex];
		this.offset.x += this.width / 2;
		this.offset.y += this.height / 2;
		var leAngle = FlxG.random.int(-180, 180);
		var leVelocity = FlxG.random.int(90, 180);
		this.velocity.set(
			Math.sin(leAngle * Constants.TO_RADIANS) * leVelocity,
			Math.cos(leAngle * Constants.TO_RADIANS) * leVelocity
		);
		this.angle = leAngle;
		this.angularVelocity = FlxG.random.int(-3, 3, [0]) * 360;
		FlxTween.tween(this, {alpha: 0}, 0.5, {
			startDelay: 0.5,
			onComplete: function(_) {
				this.destroy();
			}
		});
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
