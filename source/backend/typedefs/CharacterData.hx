package backend.typedefs;

import backend.typedefs.ModifierData;
import backend.typedefs.SkillData;

typedef CharacterData = {
	id:String,
	?cardDisplayedKey:String,
	maxPressure:Int,
	maxConfidence:Int,
	modifiers:Array<ModifierData>,
	skills:Array<SkillData>
}