package ui.objects;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;

#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class DebugText extends TextField {
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000) {
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		reloadFont(color);
		borderColor = 0x000000;
		autoSize = LEFT;
		multiline = true;
		text = "";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e) {
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	public function reloadFont(color:Int = 0xFFFFFFFF) {
		defaultTextFormat = new TextFormat(Paths.font('default'), 16, color);
		updateText();
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void {
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000) {
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount) {
			updateText();

			textColor = 0xFFFFFFFF;
			if (currentFPS <= Preferences.data.maxFramerate * 0.8) {
				textColor = 0xFFFF0000;
			}
		}

		cacheCount = currentCount;

		if (System.totalMemoryNumber > memPeak) memPeak = System.totalMemoryNumber;
	}

	private var memPeak:Float = 0;

	public function updateText() {
		visible = Preferences.data.showDebugText;
		text = '';
		if (Preferences.data.showFramerateOnDebugText)
			text += Language.getPhrase('debugText.format', [Language.getPhrase('debugText.framerate'), currentFPS]) + '\n';
		#if (openfl && !html5)
		if (Preferences.data.showMemoryUsageOnDebugText) {
			text += Language.getPhrase('debugText.format', [Language.getPhrase('debugText.memory'), Utilities.formatBytes(System.totalMemoryNumber, 1)]) + '\n';
			text += Language.getPhrase('debugText.format', [Language.getPhrase('debugText.memoryPeak'), Utilities.formatBytes(memPeak, 1)]) + '\n';
		}
		#end
		if (Preferences.data.showCurrentStateOnDebugText)
			text += Language.getPhrase('debugText.format', [Language.getPhrase('debugText.state'), Type.getClassName(Main.mainClassState)]) + '\n';
	}
}
