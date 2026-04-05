package backend.typedefs;

typedef GalleryEnvelopeData = {
	?id:String,
	?titleTranslationKey:String,
	artwork:Array<String>,
	hasCharacter:Bool,
	color:String,
	quotes:Array<String>
}
