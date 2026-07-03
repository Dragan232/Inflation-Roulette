package ui.objects;

class StageMiniCard extends SuffButton {
	public var stage:String;

	var bg:FlxSprite;
	var outline:FlxSprite;
	var charNameText:FlxText;

	public var alwaysHighlighted = false;

	public function new(x:Float, y:Float, stage:String) {
		this.stage = stage;
		super(x, y, null, null, null, Constants.CHARACTER_CARD_DIMENSIONS[0], Constants.CHARACTER_CARD_DIMENSIONS[1], false);

		bg = new FlxSprite().loadGraphic(Paths.image('ui/menus/characterSelect/stages/mini/$stage'));
		add(bg);

		outline = new FlxSprite().loadGraphic(Utilities.makeBorder(bg.width, bg.height));
		add(outline);

		charNameText = new FlxText(6, 6, width - 6 * 2, Language.getPhrase('stage.$stage.name').toUpperCase());
		charNameText.setFormat(Paths.font('small'), 32, FlxColor.WHITE);
		charNameText.setBorderStyle(OUTLINE, 0xFF000000, 0.25);
		add(charNameText);
	}

	public function setScale(x:Float, y:Float) {
		btnBG.setGraphicSize(Std.int(width * x), Std.int(height * y));
		btnBG.updateHitbox();
		for (item in [bg, outline]) {
			item.scale.set(x, y);
			item.updateHitbox();
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		outline.visible = this.hovered || alwaysHighlighted;
		outline.color = !alwaysHighlighted ? 0xFFFFFFFF : 0xFFFF00FF;

		btnBG.visible = false;
		btnOutline.visible = false;
	}
}
