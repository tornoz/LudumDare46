package states;

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

class AlbumSubState extends FlxSubState
{

	public static var ALBUM_COST = 5000; 
	private var album:Album;
	private var inputs:FlxTypedGroup<FlxText>;

    public var x = Main.HUDx;
	public var y = Main.HUDy;
	
	var parent:PlayState;

	public function new(parent:PlayState)
	{
		super();
		this.parent = parent;
	}

	override public function create()
	{
		var songNumber = 8;
		inputs = new FlxTypedGroup<FlxText>();

		var bg = new FlxSprite(x+100,y+100);
		bg.makeGraphic(600, 300, FlxColor.BLACK, true);
		add(bg);
		var age = parent.date - DateTime.make(2000, 1, 1, 0, 0, 0);
		var quality = 10 + age.getTotalMonths() * 0.5;
		add(new FlxText(x+120, y+370, "This album will have " + quality + " quality.", 10));
		add(new FlxText(x+120, y+390, "It will take 6 month to publish and will cost $"+ALBUM_COST+". Continue ?", 10));

		for(i in 0...songNumber) {
			var inp = new FlxText(x+300,y+100+i*35,0, (i+1) + ". " + RandomSongNameGenerator.getRandomSongName(), 15);
			inputs.add(inp);
		}
		add(inputs);

		var validateButton = new FlxButton(x+600, y+370, "Publish", clickPublish);
		validateButton.scrollFactor.set(1,1);
		add(validateButton);
		var cancelButton = new FlxButton(x+500, y+370, "Cancel", clickCancel);
		cancelButton.scrollFactor.set(1,1);
		add(cancelButton);


		super.create();
	}


	private function clickPublish()
	{
		album = new Album();
		for(input in inputs) {
			var song = new Song(input.text);
			album.addSong(song);
		}
		close();
	}
	private function clickCancel()
	{
		album = null;
		close();
	}

	public function getAlbum() {
		return this.album;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}


}
