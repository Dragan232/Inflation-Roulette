package ui.addons;

import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.interfaces.IFlxUIButton;
import flixel.addons.ui.FlxUIButton;

class SuffUITabMenu extends FlxUITabMenu {
	public function new(?back_:FlxSprite, ?tabs_:Array<IFlxUIButton>, ?tab_names_and_labels_:Array<{name:String, label:String}>, ?tab_offset:FlxPoint, ?stretch_tabs:Bool = false, ?tab_spacing:Null<Float> = null, ?tab_stacking:Array<String> = null) {
		super(back_, tabs_, tab_names_and_labels_, tab_offset, stretch_tabs, tab_spacing, tab_stacking);
		for (tab in this._tabs) {
			var leTab:FlxUIButton = cast tab;
			leTab.label.font = Paths.font('default');
			leTab.label.size = 16;
			leTab.resize(leTab.width, leTab.height + 16);
		}
	}
}
