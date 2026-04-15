package ui.addons;

import flixel.addons.ui.FlxUIButton;

class SuffUIButton extends FlxUIButton {
	public function new(X:Float = 0, Y:Float = 0, ?Label:String, ?OnClick:Void -> Void, ?LoadDefaultGraphics:Bool = true, ?LoadBlank:Bool = false, ?Color:FlxColor = FlxColor.WHITE) {
		super(X, Y, Label, OnClick, LoadDefaultGraphics, LoadBlank, Color);
		this.label.font = Paths.font('default');
		this.label.size = 16;
	}
}
