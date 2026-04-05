package objects;

import flixel.FlxBasic;
import states.PlayState;
import backend.typedefs.StageData;
import tjson.TJSON as Json;
import backend.typedefs.StageObjectData;
import backend.typedefs.AnimationData;
import backend.CharacterManager;

class Stage extends FlxBasic {
	private var game(get, never):PlayState;
	public var data:StageData;
	public var objects:Map<String, FlxBasic> = new Map<String, FlxBasic>();

	public function new(id:String = 'classic') {
		data = cast Json.parse(Paths.getTextFromFile('data/stages/$id.json'));
		data.id = id;
		super();
	}

	public function load() {
		var backgroundObjects:Array<StageObjectData> = data.backgroundObjects;
		var tableObjects:Array<StageObjectData> = data.tableObjects;
		var foregroundObjects:Array<StageObjectData> = data.foregroundObjects;
		for (object in backgroundObjects) {
			var obj:FlxSprite = loadObject(object, data.id);
			addBehindCharacters(object.id, obj);
		}
		for (object in tableObjects) {
			var obj:FlxSprite = loadObject(object, data.id);
			addBehindGun(object.id, obj);
		}
		for (object in foregroundObjects) {
			var obj:FlxSprite = loadObject(object, data.id);
			addObject(object.id, obj);
		}
	}

	public static function parsePosition(object:FlxSprite, pos:Array<String>):Array<Float> {
		var x:Float = 0;
		var y:Float = 0;
		if (pos[0].startsWith('c')) {
			var subtract:Bool = false;
			var arr = pos[0].split('+');
			if (arr.length <= 1) {
				arr = arr[0].split('-');
				subtract = true;
			}
			if (arr.length <= 1) {
				arr.push('0');
				subtract = false;
			}
			x = (FlxG.width - object.width) / 2 + Std.parseFloat(arr[1].trim()) * (subtract ? -1 : 1);
		} else {
			x = Std.parseFloat(pos[0]);
		}
		if (pos[1].startsWith('c')) {
			var subtract:Bool = false;
			var arr = pos[1].split('+');
			if (arr.length <= 1) {
				arr = arr[0].split('-');
				subtract = true;
			}
			if (arr.length <= 1) {
				arr.push('0');
				subtract = false;
			}
			y = (FlxG.height - object.height) / 2 + Std.parseFloat(arr[1].trim()) * (subtract ? -1 : 1);
		} else {
			y = Std.parseFloat(pos[1]);
		}
		return [x, y];
	}

	public static function loadObject(object:StageObjectData, stageID:String = 'classic') {
		trace(object);
		var obj:FlxSprite = new FlxSprite();
		if (object.animationData != null) {
			var animData:AnimationData = object.animationData;
			obj.frames = Paths.sparrowAtlas('game/stages/$stageID/' + object.graphic);
			obj.animation.addByPrefix('i', animData.prefix, animData.fps);
			obj.animation.play('i');
		} else {
			obj.loadGraphic(Paths.image('game/stages/$stageID/' + object.graphic));
		}
		if (object.scrollFactor != null && object.scrollFactor.length == 2)
			obj.scrollFactor.set(object.scrollFactor[0], object.scrollFactor[1]);
		if (object.hideCharacter != null)
			obj.visible = !CharacterManager.selectedCharacterList.contains(object.hideCharacter);
		if (object.showCharacter != null)
			obj.visible = CharacterManager.selectedCharacterList.contains(object.showCharacter);
		if (object.scale != null) {
			if (object.scale.length == 2)
				obj.scale.set(object.scale[0], object.scale[1]); else if (object.scale.length == 1)
				obj.scale.set(object.scale[0], object.scale[0]);
		}
		if (object.updateHitbox == true)
			obj.updateHitbox();
		if (object.color != null)
			obj.color = FlxColor.fromString(object.color);
		if (object.alpha != null)
			obj.alpha = object.alpha;
		if (object.blend != null)
			obj.blend = object.blend.toLowerCase();
		if (object.flipX != null)
			obj.flipX = object.flipX;
		if (object.flipY != null)
			obj.flipY = object.flipY;
		if (object.angle != null)
			obj.angle = object.angle;
		if (object.velocity != null && object.velocity.length == 2)
			obj.velocity.set(object.velocity[0], object.velocity[1]);
		if (object.angularVelocity != null)
			obj.angularVelocity = object.angularVelocity;
		obj.antialiasing = (object.antialiasing == true) && !Preferences.data.enableForceAliasing;
		var pos = parsePosition(obj, object.position);
		obj.x = pos[0];
		obj.y = pos[1];
		return obj;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function addObject(tag:String, object:FlxBasic) {
		objects.set(tag, object);
		return PlayState.instance.add(object);
	}

	public function addBehindGun(tag:String, object:FlxBasic) {
		objects.set(tag, object);
		return game.members.insert(game.members.indexOf(game.pumpGun), object);
	}

	public function addBehindCharacters(tag:String, object:FlxBasic) {
		objects.set(tag, object);
		return game.members.insert(game.members.indexOf(game.characterGroup), object);
	}

	private function get_game() {
		return cast FlxG.state;
	}
}