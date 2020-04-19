package;

import flixel.addons.ui.FlxUIButton;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class HUD extends FlxGroup
{
	public var width:Int = 800;
    public var height:Int = 600;
    
    public var x = Main.HUDx;
    public var y = Main.HUDy;

	public var dateLabel:FlxText;
    public var speedLabel:FlxText;

    public var money:FlxText;
    public var popularity:FlxText;
    public var monthlyCost:FlxText;
    public var expectation:FlxText;
    
    var parent:PlayState;

    public var stateLabel:FlxText;


	public function new(parent:PlayState)
	{
        super();
        this.parent = parent;
        var addAlbumButton = new FlxUIButton(x+600,y+20,"Record album", parent.clickRecordAlbum);
		addAlbumButton.label.size=20;
        addAlbumButton.resize(200,50);
        addAlbumButton.scrollFactor.set(1, 1);
		add(addAlbumButton);
        var goOnTourButton = new FlxUIButton(x+400,y+20,"Go on tour", parent.clickGoOnTour);
		goOnTourButton.label.size=20;
        goOnTourButton.resize(200,50);
        goOnTourButton.scrollFactor.set(1, 1);
		add(goOnTourButton);

        dateLabel = new FlxText(x+50,y+0,0,parent.date.format("%m %Y"), 20);
        speedLabel = new FlxText(x+0,y+0,0,">", 20);
        money = new FlxText(x+0, y+30, 0, "Money: $" + parent.band.money, 14);
        popularity = new FlxText(x+0, y+60, 0, "Popularity: " + parent.band.popularity, 14);
        monthlyCost = new FlxText(x+200, y+30, 0, "Monthly costs: " + parent.band.monthlyCost, 14);
        expectation = new FlxText(x+200, y+60, 0, "Expectation: " + parent.band.expectation, 14);

		stateLabel = new FlxText(x+300,y+200, 0, "", 60);
		stateLabel.color = FlxColor.RED;
		add(stateLabel);
        add(money);
        add(popularity);
        add(monthlyCost);
        add(expectation);
		add(dateLabel);
		add(speedLabel);

		var button = new FlxUIButton(x+200, y+0, "||", setPause);
        button.resize(25,25);
        add(button);
        button.scrollFactor.set(1, 1);
		button = new FlxUIButton(x+225, y+0, ">", setSlow);
		button.resize(25,25);
        button.scrollFactor.set(1, 1);
		add(button);
		button = new FlxUIButton(x+250, y+0, ">>", setFast);
		button.resize(25,25);
        button.scrollFactor.set(1, 1);
		add(button);
		button = new FlxUIButton(x+275, y+0, ">>>", setVeryFast);
		button.resize(25,25);
        button.scrollFactor.set(1, 1);
		add(button);


    }
    
	public function setPause() {
		parent.setSpeed(Speed.PAUSE);
	}
	public function setSlow() {
		parent.setSpeed(Speed.SLOW);
	}
	public function setFast() {
		parent.setSpeed(Speed.FAST);
	}
	public function setVeryFast() {
		parent.setSpeed(Speed.VERY_FAST);
	}



}