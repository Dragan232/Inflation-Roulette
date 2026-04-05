package backend.typedefs;

typedef StageObjectData = {
	id:String,
	graphic:String,
	position:Array<String>,
	?hideCharacter:String, // Hide this graphic when this character is in the game.
	?showCharacter:String, // Show this graphic when this character is in the game.
	?angle:Float,
	?alpha:Float,
	?flipX:Bool,
	?flipY:Bool,
	?blend:String,
	?color:String,
	?scrollFactor:Array<Float>,
	?scale:Array<Float>,
	?updateHitbox:Bool,
	?animationData:AnimationData,
	?antialiasing:Bool,
	?angularVelocity:Float,
	?velocity:Array<Float>
}
