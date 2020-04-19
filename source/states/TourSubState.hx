package states;

import model.Cities;
import flixel.math.FlxRandom;
import model.Show;
import datetime.DateTime;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxRect;
import flixel.addons.ui.FlxInputText;
import flixel.system.FlxSoundGroup;
import model.Album;
import model.Song;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import flixel.FlxSubState;
import flixel.FlxSprite;
import model.RandomSongNameGenerator;
import flixel.addons.ui.FlxUIInputText;

class TourSubState extends FlxSubState
{

	public static var SHOW_COST = 5000; 
	private var album:Album;
	private var placesLabel:FlxTypedGroup<FlxText>;

    public var x = Main.HUDx;
	public var y = Main.HUDy;
	
	public var tourCost = 0;

	var parent:PlayState;
	var ok = false;

	var shows:Array<Show>;

	public function new(parent:PlayState)
	{
		super();
		this.parent = parent;
		placesLabel = new FlxTypedGroup<FlxText>();
	}

	override public function create()
	{
		var showNumber = Math.round(Math.max(5,parent.band.popularity/100));
		var rand = new FlxRandom();
		var bg = new FlxSprite(x+100,y+100);
		bg.makeGraphic(600, 300, FlxColor.BLACK, true);
		add(bg);
		shows = new Array<Show>();
		for(i in 0...(showNumber-1)) {
			var show = new Show();
			show.date = parent.date.add(Month(i));
			show.place = Cities.cityNames[rand.int(0, Cities.cityNames.length-1)];
			shows.push(show);
			var inp = new FlxText(x+300,y+100+i*35,0, show.date.format("%m %Y") + " @ " + show.place);
			placesLabel.add(inp);
		}

		add(placesLabel);

		tourCost = SHOW_COST + (showNumber*500);
		add(new FlxText(x+120, y+390, "The tour will cost "+tourCost+". Continue ?", 10));

		var validateButton = new FlxButton(x+600, y+370, "Start tour", clickPublish);
		validateButton.scrollFactor.set(1,1);
		add(validateButton);
		var cancelButton = new FlxButton(x+500, y+370, "Cancel", clickCancel);
		cancelButton.scrollFactor.set(1,1);
		add(cancelButton);

		super.create();
	}


	private function clickPublish()
	{
		ok = true;
		for(input in placesLabel) {
			for(show in shows) {
				parent.band.addShow(show);
			}
		}
		close();
	}
	private function clickCancel()
	{
		ok = false;
		close();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function getOK() {
		return ok;
	}


}
