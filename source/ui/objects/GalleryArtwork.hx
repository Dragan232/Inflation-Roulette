package ui.objects;

import states.extras.GalleryArtworkViewState;

using flixel.util.FlxBitmapDataUtil;

class GalleryArtwork extends SuffButton {
	static final maxWidth:Float = 720;
	static final maxHeight:Float = 540;
	public function new(x:Float, y:Float, path:String) {
		var leGraphic = Paths.image('ui/menus/extras/gallery/images/' + path);
		var image:FlxSprite = new FlxSprite().loadGraphic(leGraphic);
		var leScale = Math.min(maxWidth / image.width, maxHeight / image.height);
		if (leScale > 1) leScale = Std.int(leScale);
		image.scale.set(leScale, leScale);
		image.updateHitbox();
		super(x, y, null, null, null, image.width, image.height, false);
		this.clickSound = '';
		this.releaseSound = 'ui/extras/gallery/envelopeClick';
		this.hoverSound = 'ui/extras/gallery/envelopeHover';
		this.tooltipText = Language.getPhrase('galleryEntryMenu.viewFullImage');
		this.onHover = function() {
			FlxTween.cancelTweensOf(this, ['angle']);
			FlxTween.tween(this, {'angle': 5}, 0.25, {
				ease: FlxEase.quintOut
			});
		};
		this.onIdle = function () {
			FlxTween.cancelTweensOf(this, ['angle']);
			FlxTween.tween(this, {'angle': 0}, 0.25, {
				ease: FlxEase.quintOut
			});
		};
		this.onClick = function () {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			GalleryArtworkViewState.path = '$path';
			SuffState.switchState(new GalleryArtworkViewState());
		};
		add(image);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
