package shaders;

import flixel.system.FlxAssets.FlxShader;

class GrayscaleShader extends FlxShader {
	// Original code: Desaturate filter, by sepehr
	// https://www.shadertoy.com/view/lsdXDH

	@:glFragmentSource('
	#pragma header
	vec4 desaturate(vec4 color, float factor) {
		vec3 lum = vec3(0.2126, 0.7152, 0.0722);
		vec3 gray = vec3(dot(lum, color.rgb));
		return vec4(mix(color.rgb, gray, factor), color.a);
	}

	void main() {
		vec2 uv = openfl_TextureCoordv.xy;
		gl_FragColor = desaturate(texture2D(bitmap, uv), 1.0);
	}
	')

	public function new() {
		super();
	}
}
