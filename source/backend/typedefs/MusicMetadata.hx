package backend.typedefs;

typedef MusicMetadata = {
	name:String,
	author:String,
	bpm:Float,
	?loopTime:Float,
	toast:Bool,
	?album:String
}
