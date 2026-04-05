package ui.objects;

class AchievementIcon extends FlxSprite {
	public function new(x:Float, y:Float, id:String, locked:Bool = false) {
		super(x, y);

		loadIconGraphic(id, locked);
	}

	public function loadIconGraphic(id:String, locked:Bool = false) {
		if (Preferences.data.allowPopping && Paths.fileExists(Paths.getImagePath
		('ui/menus/achievements/icons/${id}_popping')))
			id = id + '_popping';
		var iconPath = 'ui/menus/achievements/icons/$id';
		if (!Paths.fileExists(Paths.getImagePath(iconPath)))
			iconPath = 'ui/menus/achievements/icons/fallback/placeholder';
		if (Achievements.achievementsList.exists(id) && Achievements.achievementsList.get(id).hideIcon == true && locked)
			iconPath = 'ui/menus/achievements/icons/fallback/hidden';

		loadGraphic(Paths.image(iconPath));
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
