package shaders;

import flixel.system.FlxAssets.FlxShader;

class MosaicShader extends FlxShader {
	@:glFragmentSource('
	#pragma header
	uniform float pixels;

	void main() {
		vec2 texSize = openfl_TextureSize.xy / pixels;

		vec2 texelCoord = (openfl_TextureCoordv.xy / openfl_TextureSize.xy) * texSize;

		vec2 f = fract(texelCoord);
		f = clamp((f - 0.5) / fwidth(texelCoord) + 0.5, 0.0, 1.0);

		vec2 finalUV = (floor(texelCoord) + f) / texSize;
		gl_FragColor = texture2D(bitmap, finalUV);
	}
	')
	public function new(pixel:Int = 16) {
		super();
		pixels.value = [pixel];
	}

	public function update(elapsed:Float) {

	}
}