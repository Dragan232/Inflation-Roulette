package ui.addons;

import flixel.addons.ui.FlxUIList.STACK_HORIZONTAL;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.FlxUINumericStepper;

class SuffUINumericStepper extends FlxUINumericStepper {
	public function new(X:Float = 0, Y:Float = 0, StepSize:Float = 1, DefaultValue:Float = 0, Min:Float = -999, Max:Float = 999, Decimals:Int = 0, Size:Int = 16, Stack:Int = STACK_HORIZONTAL, ?TextField:FlxText, ?ButtonPlus:FlxUITypedButton<FlxSprite>, ?ButtonMinus:FlxUITypedButton<FlxSprite>, IsPercent:Bool = false) {
		super(X, Y, StepSize, DefaultValue, Min, Max, Decimals, Stack, TextField, ButtonPlus, ButtonMinus, IsPercent);
		this.text_field.font = Paths.font('default');
		this.text_field.size = Size;
		if ('$Min'.length + 1 + Decimals > '$Max'.length + 1 + Decimals)
			this.text_field.text = '$Min';
		else
			this.text_field.text = '$Max';
		this.text_field.fieldWidth = 0;
		this.text_field.fieldWidth = this.text_field.width;
		this.text_field.text = '$DefaultValue';

		this.button_plus.resize(this.height, this.height);
		this.button_minus.resize(this.height, this.height);
		this.button_plus.x = this.text_field.x + this.text_field.width;
		this.button_minus.x = this.button_plus.x + this.button_plus.width;
		this.button_minus.y = this.button_plus.y;
	}
}
