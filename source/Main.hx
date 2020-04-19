package;

import states.BandCreationState;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	// public static var HUDx = -1000000;
	// public static var HUDy = -1000000;
	public static var HUDx = -1000000;
	public static var HUDy = -1000000;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, BandCreationState, 1,60,60,true));
	}
}
