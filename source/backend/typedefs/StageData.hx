package backend.typedefs;

typedef StageData = {
	id:String,
	music:String,
	stageCameraZoom:Float,
	characterCameraZoom:Float,
	?selectLightColor:String,
	cameraBounds:Array<Float>,
	backgroundObjects:Array<StageObjectData>,
	tableObjects:Array<StageObjectData>,
	foregroundObjects:Array<StageObjectData>,
	characterX:Array<Float>,
	characterY:Float,
	gunY:Float,
	gunScrollFactor:Array<Float>
}
