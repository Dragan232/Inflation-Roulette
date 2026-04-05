package ui.objects;
import ui.objects.JukeboxBarText.JukeboxBarTextCharacter;
import ui.objects.JukeboxBarText.JukeboxBarTextCharacter;
class JukeboxBarText extends FlxSpriteGroup {
	public function new(x, y, text = '') {
		super();

		var leX:Float = -(JukeboxBarTextCharacter.pixelSize * JukeboxBarTextCharacter.baselineX);
		var leY:Float = -(JukeboxBarTextCharacter.pixelSize * JukeboxBarTextCharacter.ascenderHeight);
		for (i in 0...text.length) {
			var char = text.charAt(i);
			var glyph:JukeboxBarTextCharacter = new JukeboxBarTextCharacter(leX, leY, char);
			add(glyph);

			leX += glyph.width + (JukeboxBarTextCharacter.pixelSize * JukeboxBarTextCharacter.spacing) -
			(JukeboxBarTextCharacter.pixelSize * JukeboxBarTextCharacter.baselineX);
		}
		this.x = x;
		this.y = y;
	}

	public function setScale(x:Float = 1, y:Float = 1) {
		for (num => glyph in members) {
			glyph.scale.set(x, y);
			glyph.updateHitbox();
			glyph.x = this.x + num * JukeboxBarTextCharacter.glyphWidth * JukeboxBarTextCharacter.pixelSize * x;
		}
	}

	override public function update(elapsed:Float) {
		this.offset.x = Math.round(this.offset.x / JukeboxBarTextCharacter.pixelSize) * JukeboxBarTextCharacter.pixelSize;
		this.offset.y = Math.round(this.offset.y / JukeboxBarTextCharacter.pixelSize) * JukeboxBarTextCharacter.pixelSize;

		super.update(elapsed);
	}
}

class JukeboxBarTextCharacter extends FlxSprite {
	static final glyphs:String = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	public static final pixelSize:Int = 4;
	public static final ascenderHeight:Int = 4;
	public static final spacing:Int = 1;
	public static final baselineX:Int = 2;
	public static final glyphWidth:Int = 9;
	public static final glyphHeight:Int = 18;
	public static final typeSize:Int = 14;

	public function new(x, y, character = '') {
		super(x, y);

		//trace(character, glyphs);

		var path = '${character.fastCodeAt(0)}';
		if (!Paths.fileExists(Paths.getImagePath('ui/menus/extras/jukebox/bar/glyphs/' + path)))
			path = 'missing';
		this.loadGraphic(Paths.image('ui/menus/extras/jukebox/bar/glyphs/' + path));
		this.antialiasing = !Preferences.data.enableForceAliasing;
	}
}
