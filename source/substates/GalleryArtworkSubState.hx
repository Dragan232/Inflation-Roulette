package substates;

import ui.objects.SuffIconButton;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxSpriteContainer;
import ui.objects.GalleryArtwork;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import backend.typedefs.GalleryArtworkMetadata;
import tjson.TJSON as Json;

class GalleryArtworkSubState extends SuffSubState {
	var allowInput:Bool = false;
	var artworkGroup:FlxTypedSpriteGroup<GalleryArtwork> = new FlxTypedSpriteGroup<GalleryArtwork>();
	var envelopeID:String = '';
	var artwork:Array<String> = [];

	var leftButton:SuffIconButton;
	var rightButton:SuffIconButton;
	var exitButton:SuffIconButton;
	var text:FlxText;
	var description:FlxText;

	var curSelected:Int = 0;

	public function new(id:String, artwork:Array<String>) {
		super();

		this.envelopeID = id;
		this.artwork = artwork;
		persistentUpdate = false;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.625;
		add(bg);

		add(artworkGroup);
		for (num => art in artwork) {
			var art:GalleryArtwork = new GalleryArtwork(0, 0, '$id/$art');
			art.x = (FlxG.width - art.width) / 2 + FlxG.width * num;
			art.y = (FlxG.height - (art.height + 64)) / 2;
			artworkGroup.add(art);
		}
		artworkGroup.y = FlxG.height;
		FlxTween.tween(artworkGroup, {y: 0}, 0.25, {
			ease: FlxEase.quintOut
		});

		text = new FlxText(0, 0, FlxG.width * 0.5, '', 16);
		text.alignment = CENTER;
		text.screenCenter(X);
		add(text);

		description = new FlxText(0, 0, FlxG.width * 0.5, '', 16);
		description.alignment = JUSTIFY;
		description.screenCenter(X);
		add(description);

		leftButton = new SuffIconButton(20, 20, 'buttons/left', null, 2);
		leftButton.screenCenter();
		leftButton.x = (FlxG.width - leftButton.width) / 2 - FlxG.width * 0.375;
		leftButton.onClick = function() {
			changeSelection(-1);
		};
		add(leftButton);

		rightButton = new SuffIconButton(20, 20, 'buttons/right', null, 2);
		rightButton.screenCenter();
		rightButton.x = (FlxG.width - rightButton.width) / 2 + FlxG.width * 0.375;
		rightButton.onClick = function() {
			changeSelection(1);
		};
		add(rightButton);

		exitButton = new SuffIconButton(20, 20, 'buttons/exit', null, 2);
		exitButton.x = FlxG.width - exitButton.width - 20;
		exitButton.onClick = function() {
			exitMenu();
		};
		add(exitButton);

		allowInput = true;
		changeSelection();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (!allowInput) return;
		if (FlxG.keys.justPressed.ESCAPE) {
			exitMenu();
		}
	}

	function changeSelection(delta:Int = 0) {
		curSelected = FlxMath.wrap(curSelected + delta, 0, artworkGroup.members.length - 1);
		artworkGroup.x = curSelected * -FlxG.width;
		FlxTween.cancelTweensOf(artworkGroup);
		artworkGroup.y = 0;
		var artworkData:GalleryArtworkMetadata = cast Json.parse(Paths.getTextFromFile('data/extras/gallery/art/${envelopeID}/${artwork[curSelected]}.json'));
		text.text = '(${curSelected + 1} / ${artwork.length})\n' + artworkData.title + ' - ' + artworkData.artist;
		text.y = Std.int(artworkGroup.members[curSelected].y + artworkGroup.members[curSelected].height - artworkGroup.y);
		description.text = artworkData.description;
		// description.updateHitbox();
		description.alignment = description.height <= 32 ? CENTER : JUSTIFY;
		description.y = text.y + text.height;

		artworkGroup.y = 20;
		FlxTween.tween(artworkGroup, {y: 0}, 0.25, {
			ease: FlxEase.quintOut
		});
	}

	function exitMenu() {
		if (!allowInput) return;
		allowInput = false;
		persistentUpdate = true;
		close();
	}
}
