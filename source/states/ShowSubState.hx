package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSubState;

class BandCreationState extends FlxSubState
{

    public var x = Main.HUDx;
    public var y = Main.HUDy;

    public var rectangleOfPerfection:FlxSprite;

    public var notes:FlxTypedGroup<FlxSprite>;

	override public function create()
    {
        var bg = new FlxSprite(x+100,y+100);
		bg.makeGraphic(700, 400, FlxColor.BROWN, true);
        add(bg);
        

        var rectangleOfPerfection = new FlxSprite(x+100,y+400);
		rectangleOfPerfection.makeGraphic(700, 50, FlxColor.GREEN, true);
        add(rectangleOfPerfection);
        
        var rand = new FlxRandom();
        for(i in 0...rand.int(20,30)) {
            notes.push(new FlxText());
        }
		super.create();
    }


	override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }

}