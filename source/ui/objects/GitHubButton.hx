package ui.objects;

import flixel.graphics.FlxGraphic;

class GitHubButton extends SuffIconButton {
	public function new(x:Float, y:Float, directory:String = '') {
		super(x, y, 'buttons/github');

		this.btnBGColor = 0xFF000000;
		this.btnBGColorHovered = 0xFF202020;
		this.btnBGColorClicked = 0xFF808080;
		this.btnBGColorDisabled = 0xFFFFFFFF;
		this.btnOutlineColor = this.btnOutlineColorDisabled = 0xFFC0C0C0;
		this.btnOutlineColorHovered = this.btnOutlineColorClicked = 0xFFFFFFFF;
		this.btnTextColor = this.btnTextColorHovered = this.btnTextColorClicked = 0xFFFFFFFF;
		this.btnTextColorDisabled = 0xFF96A199;

		this.onClick = function() {
			Utils.browserLoad('https://github.com/Sufferneer/Inflation-Roulette/' + directory);
		};
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
