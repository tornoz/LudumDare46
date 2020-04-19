package states;

import flixel.addons.ui.FlxUIPopup;

class SimplePopup extends FlxUIPopup
{
	override public function create():Void
	{
		super.create();
	}

	override public function getEvent(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (params != null)
		{
			if (id == "click_button")
			{
				switch (Std.int(params[0]))
				{
					case 0:
						close();
				}
			}
		}
	}
}