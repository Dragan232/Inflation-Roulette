package backend;

import backend.Gamemode;

class GameplayManager {
	public static var currentStage:String = 'reloaded';
	public static var globalStageList:Array<String> = ['reloaded'];

	public static var defaultGamemode:Gamemode;
	public static var currentGamemode:Gamemode;

	public function new() {
		// ass
	}

	public static function initialize() {
		defaultGamemode = new Gamemode('reloaded');
		currentGamemode = new Gamemode('reloaded');

		globalStageList = Paths.readDirectories('data/stages', 'data/stages/stageList.txt', 'json');
	}
}
