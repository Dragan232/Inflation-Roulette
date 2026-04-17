package ui.objects;

class JukeboxRecord extends FlxSpriteGroup {
	var label:FlxSprite;
	var base:FlxSprite;

	public var album(default, set):String = 'volume1';

	public function new(x, y, ?album:String = 'volume1') {
		super();

		label = new FlxSprite();
		label.antialiasing = !Preferences.data.enableForcedAliasing;
		add(label);

		base = new FlxSprite().loadGraphic(Paths.image('ui/menus/extras/jukebox/record/base'));
		base.antialiasing = !Preferences.data.enableForcedAliasing;
		add(base);

		this.album = album;

		this.x = x;
		this.y = y;
	}

	private function set_album(value:String) {
		this.album = value;
		label.loadGraphic(Paths.image('ui/menus/extras/jukebox/albumCovers/$value'));
		label.setPosition(
			this.x + (base.width - label.width) / 2,
			this.y + (base.height - label.height) / 2
		);
		return album;
	}
}
