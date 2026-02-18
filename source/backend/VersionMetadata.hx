package backend;

class VersionMetadata {
	public static function getVersionName(version:String) {
		var arr = version.split('.');
		var text = Language.getPhrase('game.version.name.major.' + arr[0]);
		text += ' (';
		if (Std.parseInt(arr[1]) > 0)
			text += Language.getPhrase('game.version.name.minor.format', [arr[1]]);
		if (arr[2] != null && Std.parseInt(arr[2]) > 0)
			text += ' ' + Language.getPhrase('game.version.name.hotfix.format', [arr[2]]);
		text += ')';
		return text;
	}

	public function new() {}
}
