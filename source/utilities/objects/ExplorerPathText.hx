package utilities.objects;

import ui.objects.SuffTextButton;
import utilities.states.CharacterCreatorState;

class ExplorerPathText extends FlxSpriteGroup {
	public var fullPath:Array<String> = [];
	public var onManualUpdatePath:String->Void;
	public function new(x:Float, y:Float) {
		super(x, y);
	}

	public function setPath(lePath:String) {
		this.clear();
		var leX:Float = 0;
		fullPath = lePath.split('/');
		if (fullPath[fullPath.length - 1].length <= 0) fullPath.pop();
		var textPath = '';
		for (num => item in fullPath) {
			textPath = textPath + item + '/';
			var text:SuffTextButton = new SuffTextButton(leX, 0, item, 16, FlxPoint.weak(0, 0));
			var leText = textPath;
			text.onClick = function () {
				CharacterCreatorState.explorerCurPath = leText;
				setPath(leText);
				CharacterCreatorState.instance.generateExplorer();
			}
			add(text);
			leX += text.width;

			var arrow:FlxText = new FlxText(leX, 0, 0, ' > ', 16);
			add(arrow);
			leX += arrow.width;
		}
	}

	public function getLastPath() {
		return fullPath[fullPath.length - 1];
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
