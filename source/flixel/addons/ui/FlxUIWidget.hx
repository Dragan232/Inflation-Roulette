package flixel.addons.ui;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Harpwood Studio
 * https://harpwood.itch.io/
 */

class FlxUIWidget extends FlxUIGroup {
	var area:FlxUI9SliceSprite;
	var areaWidth:Int;
	var areaHeight:Int;
	var areaMinimizedHeight:Int = 36;
	var label:FlxText;
	var canMove:Bool = false;
	var dragArea:FlxSprite;
	var minBtn:FlxUIButton;
	var isMinimized:Bool = false;
	public var draggable:Bool = true;

	public var components:Array<FlxBasic>;

	public function new(X:Float = 0, Y:Float = 0, Width:Int = 200, Height:Int = 200) {
		super(X, Y);

		x = X;
		y = Y;
		areaWidth = Width;
		areaHeight = Height;

		area = new FlxUI9SliceSprite(0, 0, FlxUIAssets.IMG_CHROME, new Rectangle(0, 0, Width, Height));
		add(area);

		dragArea = new FlxSprite();
		dragArea.visible = false;
		dragArea.makeGraphic(Width - 45, 25, 0x00);
		dragArea.setPosition(5, 5);
		add(dragArea);

		minBtn = new FlxUIButton(Width - 37, 6, '-', toggle);
		minBtn.setLabelFormat(32);
		minBtn.resize(30, 24);
		add(minBtn);

		label = new FlxText(0, 7, Width - 35, 'UI Object', 16);
		label.color = FlxColor.WHITE;
		label.alignment = "center";
		add(label);

		components = [];
	}

	public function addObject(obj:Dynamic) {
		this.add(obj);
		this.components.push(obj);
	}

	public function clearObjects() {
		for (ob in components) {
			var obj:FlxSprite = cast ob;
			this.remove(obj);
			obj.kill();
			obj.destroy();
		}
	}

	public function toggle():Void {
		minBtn.toggled = false;
		isMinimized = !isMinimized;

		area.resize(areaWidth, isMinimized ? areaMinimizedHeight : areaHeight);

		for (i in 0...components.length) {
			components[i].visible = !isMinimized;
		}
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (!draggable) return;
		if (FlxG.mouse.overlaps(dragArea, this.camera) && FlxG.mouse.justPressed && !canMove) {
			canMove = true;
		}
		if (FlxG.mouse.pressed && canMove) {
			x += FlxG.mouse.deltaScreenX;
			y += FlxG.mouse.deltaScreenY;
		}
		if (FlxG.mouse.justReleased && canMove) {
			canMove = false;
		}
	}

	public function setLabelText(text:String):Void {
		label.text = text;
	}

}