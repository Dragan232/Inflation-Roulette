package shaders;

import flixel.system.FlxAssets.FlxShader;

class GaussianBlurShader extends FlxShader {
	@:glFragmentSource('
	const float PI = 3.141592654;
	uniform float Directions;
	uniform float Quality;
	uniform float Size;

	void main() {
		vec2 Radius = Size / openfl_TextureSize;
		vec2 uv = openfl_TextureCoordv.xy;
		vec4 Color = texture2D(bitmap, uv);

		// Blur calculations
		for (float d = 0.0; d < PI * 2.0; d += PI * 2.0 / Directions) {
			for (float i = 1.0 / Quality; i <= 1.0; i += 1.0 / Quality) {
				Color += texture(bitmap, uv + vec2(cos(d), sin(d)) * Radius * i);
			}
		}

		Color /= Quality * Directions - 15.0;
		gl_FragColor = Color;
	}
    ')
	public function new(Size:Float = 8.0) {
		super();
		Directions.value = [16.0];
		Quality.value = [8.0];
		this.Size.value = [Size];
	}
}