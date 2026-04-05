package objects.particles;

import flixel.effects.particles.FlxParticle;

class Scrap extends FlxParticle {
	var _swaySpeed:Float = 3;
	var _swayDist:Float = 180;

	public static var floorY:Float = 690;

	public function new() {
		super();
		this._swaySpeed = FlxG.random.float(1, 3);
		this._swayDist = FlxG.random.float(45, 180);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (y + velocity.y * elapsed >= floorY - height * 0.5) {
			velocity.y = 0;
			acceleration.y = 0;
			angle = FlxMath.lerp(angle, 0, elapsed * 3);
		} else {
			offset.x = Math.sin(age * _swaySpeed) * _swayDist;
			angle = Math.sin(age * _swaySpeed) * _swayDist / 5;

			velocity.y = FlxMath.lerp(velocity.y, 150, elapsed * 3);
		}
		velocity.x = FlxMath.lerp(velocity.x, 0, elapsed * 5);
	}
}
