package backend;

class VersionMetadata {
	public static function getVersionName(curVersion:String) {
		var version = curVersion.split('-');
		var arr = version[0].split('.');
		var state:String = version[1];
		var text = Language.getPhrase('game.version.name.major.' + arr[0]);
		appendices = [];
		if (arr[1] != null && Std.parseInt(arr[1]) > 0) {
			addAppendix(Language.getPhrase('game.version.name.minor.format', [arr[1]]));
		}
		if (arr[2] != null) {
			if (Std.parseInt(arr[2]) > 0) {
				addAppendix(Language.getPhrase('game.version.name.hotfix.format', [arr[2]]));
			}
		}
		if (state != null) {
			addAppendix(Language.getPhrase('game.version.name.state.' + state.charAt(0), [state.substr(1, state.length - 1)]));
		}
		if (appendices.length > 0) {
			appendices.push(')');
			appendices.unshift(' (');
		}
		return text + appendices.join('');
	}

	static var appendices:Array<String> = [];

	static function addAppendix(str:String) {
		if (appendices.length > 0)
			appendices.push(' ');
		appendices.push(str);
	}

	public function new() {}
}
