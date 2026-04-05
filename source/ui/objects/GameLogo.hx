package ui.objects;

class GameLogo extends FlxSpriteGroup {
	public static final logoScale:Float = 0.35;
	var logo:FlxSprite;
	var logoOriginalOffset:FlxPoint;
	var version:FlxSprite;
	var versionOriginalOffset:FlxPoint;

	public var showVersion(default, set):Bool = false;
	public var animated:Bool = true;

    public function new(x, y, animated:Bool = true) {
        super(x, y);
		this.animated = animated;
		logo = new FlxSprite().loadGraphic(Paths.image('ui/menus/gameLogo'));
		logo.scale.set(logoScale, logoScale);
		logo.updateHitbox();
		logoOriginalOffset = logo.offset.clone();
		version = new FlxSprite().loadGraphic(Paths.image('ui/menus/gameUpdate'));
		version.scale.set(logoScale, logoScale);
		version.updateHitbox();
		versionOriginalOffset = version.offset.clone();
		version.setPosition((logo.width - version.width) / 2, (logo.height - version.height) / 2);
		add(version);
		add(logo);
    }

	private function set_showVersion(value:Bool) {
		showVersion = value;
		version.visible = showVersion;
		if (showVersion) {
			if (animated) {
				FlxTween.tween(logo, {'offset.y': logoOriginalOffset.y + logo.height * 0.3}, 1.25, {ease: FlxEase.expoOut});
				FlxTween.tween(version, {'offset.y': versionOriginalOffset.y + logo.height * -0.3}, 1.25, {ease: FlxEase.bounceOut});
				SuffState.playUISound(Paths.sound('ui/mainMenu/versionReveal'));
			} else {
				logo.offset.y = logoOriginalOffset.y + logo.height * 0.3;
				version.offset.y = versionOriginalOffset.y + logo.height * -0.3;
			}
		} else {
			logo.offset.y = logoOriginalOffset.y;
			version.offset.y = versionOriginalOffset.y;
		}
		return value;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}