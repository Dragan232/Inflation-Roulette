package utilities.objects;

class TemplateImage extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0, width:Float = 640, height:Float = 640, path:String = 'silhouette') {
        super(x, y);
        loadGraphic(Paths.image('ui/menus/utilities/$path'));
		setGraphicSize(Std.int(width), Std.int(height));
		updateHitbox();
	}
}
