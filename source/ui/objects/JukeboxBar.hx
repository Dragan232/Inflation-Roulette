package ui.objects;

import backend.typedefs.MusicMetadata;
import backend.typedefs.MusicAlbumMetadata;
import tjson.TJSON as Json;

class JukeboxBar extends FlxSpriteGroup {
	var back:FlxSprite;
	var text:JukeboxBarText;
	var textTween:FlxTween;
	var textTimer:FlxTimer;
	var base:FlxSprite;
	var albumText:FlxText;
	var authorText:FlxText;

	public var musicID:String = 'mainMenu';
	public var music:MusicMetadata;
	public var album:MusicAlbumMetadata;

	public function new(x, y, musicID:String = 'mainMenu') {
		super();

		this.musicID = musicID;
		this.music = cast Json.parse(Paths.getTextFromFile('music/$musicID.json'));
		this.album = cast Json.parse(Paths.getTextFromFile('data/extras/jukebox/albums/${music.album}.json'));

		back = new FlxSprite().loadGraphic(Paths.image('ui/menus/extras/jukebox/bar/back'));
		back.antialiasing = !Preferences.data.enableForceAliasing;
		add(back);

		text = new JukeboxBarText(40, 36, music.name);
		var hue = FlxColor.fromString(album.color).hue;
		text.color = FlxColor.fromHSB(hue, 0.5, 1);
		updateClipRect();
		add(text);

		base = new FlxSprite().loadGraphic(Paths.image('ui/menus/extras/jukebox/bar/base'));
		add(base);

		albumText = new FlxText(12, 12, 0, album.name, 16);
		albumText.font = Paths.font('default', false);
		albumText.color = 0xFF202020;
		albumText.y = 120 + (30 - albumText.height) / 2;
		add(albumText);

		authorText = new FlxText(12, 12, 0, music.author, 16);
		authorText.font = Paths.font('default', false);
		authorText.color = 0xFF202020;
		authorText.x = width - authorText.width - 12;
		authorText.y = 120 + (30 - authorText.height) / 2;
		add(authorText);

		this.x = x;
		this.y = y;
	}

	public override function update(elapsed:Float) {
		this.width = base.width;
		this.height = base.height;

		super.update(elapsed);
	}

	public function resetTextPanning() {
		if (text.width <= 520) return;
		initTextPanning();
		textTimer = new FlxTimer().start(1.0, function(_) {
			panTextToRight();
		});
	}

	public function initTextPanning() {
		if (textTween != null)
			textTween.cancel();
		if (textTimer != null)
			textTimer.cancel();
		text.offset.x = 0;
		updateClipRect();
	}

	function updateClipRect() {
		text.clipRect = FlxRect.get(-20 + text.offset.x, -16, 560, 80);
	}

	function panTextToLeft() {
		textTween = FlxTween.tween(text.offset, {x: 0}, 6 * (text.width - 520) / 520, {
			onComplete: function (_) {
				textTimer = new FlxTimer().start(1.0, function(_) {
					panTextToRight();
				});
			},
			onUpdate: function (_) {
				updateClipRect();
			}
		});
	}

	function panTextToRight() {
		textTween = FlxTween.tween(text.offset, {x: text.width - 520}, 6 * (text.width - 520) / 520, {
			onComplete: function (_) {
				textTimer = new FlxTimer().start(1.0, function(_) {
					panTextToLeft();
				});
			},
			onUpdate: function (_) {
				updateClipRect();
			}
		});
	}

	private override function get_width() {
		return base.width;
	}

	private override function get_height() {
		return base.height;
	}
}
