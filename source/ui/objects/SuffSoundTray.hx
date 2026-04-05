package ui.objects;

import flixel.system.ui.FlxSoundTray;
import openfl.display.Bitmap;
import openfl.utils.Assets;

class SuffSoundTray extends FlxSoundTray {
	public function new() {
		super();
		removeChildren();

		var bg:Bitmap = new Bitmap(Assets.getBitmapData(Paths.getImagePath("ui/soundTray/volumebox")));
		addChild(bg);

		y = -height;
		visible = false;
	}
}