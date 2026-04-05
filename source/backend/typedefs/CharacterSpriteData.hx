package backend.typedefs;

typedef CharacterSpriteData = {
	spriteSheetsMandatory:Array<String>,
	spriteSheetsGameplay:Array<String>,
	?spriteSheets:Array<String>,
	animations:Array<AnimationData>,
	belchThreshold:Int,
	gurgleThreshold:Int,
	creakThreshold:Int,
	antialiasing:Bool,
	disablePopping:Bool,
	originPosition:Array<Int>,
	poppedCameraOffset:Array<Int>,
	cameraOffset:Array<Int>,
	headParticlePosition:Array<Int>,
	poppingVelocityMultiplier:Array<Float>,
	poppingGravityMultiplier:Float
}
