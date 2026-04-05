package ui.objects;

class SuffTextButton extends SuffButton {
	public function new(x:Float, y:Float, text:String, visibleBG:Bool = false, size:Float = 48, fontPath:String = null, margin:FlxPoint = null) {
		if (margin == null) margin = FlxPoint.weak(8, 8);
		var leText:FlxText = new FlxText(0, 0, 0, text);
		if (fontPath == null)
			fontPath = Paths.font('default');
		leText.setFormat(fontPath, Std.int(size));

		super(x, y, text, null, null, Std.int(leText.width + margin.x * 2), Std.int(leText.height + margin.y * 2), visibleBG);
		this.btnTextFontPath = fontPath;
		this.btnTextSize = Std.int(size);

		leText.destroy();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
