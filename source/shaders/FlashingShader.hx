package shaders;

import flixel.system.FlxAssets.FlxShader;

class FlashingShader extends FlxShader {
	@:glFragmentSource('
	#pragma header
	uniform float iTime;
	uniform vec3 flashColor;
	uniform float flashThreshold;

	void main() {
		vec4 originalColor = texture2D(bitmap, openfl_TextureCoordv);
		float amount = pow(sin(iTime), 2.);
		gl_FragColor = vec4(mix(originalColor.rgb, mix(vec3(0, 0, 0), flashColor, originalColor.a), amount * flashThreshold), originalColor.a);
	}
	')

	public var flashSpeed:Float = 2.0;
	public var time(default, set):Float = 0.0;
	public var threshold(default, set):Float = 0.75;
	public var color(default, set):Array<Float> = [1, 1, 1];

	private function set_time(value:Float):Float {
		time = value;
		iTime.value = [value];
		return value;
	}

	private function get_time() {
		return iTime.value[0];
	}

	private function set_color(value:Array<Float>):Array<Float> {
		color = value;
		flashColor.value = [value[0], value[1], value[2]];
		return value;
	}

	private function get_color():Array<Float> {
		return flashColor.value;
	}

	private function set_threshold(value:Float):Float {
		threshold = value;
		flashThreshold.value = [value];
		return value;
	}

	private function get_threshold() {
		return flashThreshold.value[0];
	}

	public function new(r:Float = 1, g:Float = 1, b:Float = 1) {
		super();
		time = 0.0;
		threshold = 0.75;
		color = [r, g, b];
		flashSpeed = 0.0;
	}

	public function update(elapsed:Float) {
		time += elapsed * flashSpeed;
	}
}
