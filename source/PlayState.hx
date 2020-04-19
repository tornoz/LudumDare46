package;

import flixel.math.FlxRandom;
import model.Show;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.addons.ui.FlxUIButton;
import flixel.text.FlxText;
import datetime.DateTime;
import lime.system.BackgroundWorker;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxState;
import states.AlbumSubState;
import model.Band;
import flixel.FlxG;
import model.Cities;
import states.SimplePopup;
import states.TourSubState;
class PlayState extends FlxState
{

	var albumSubState:AlbumSubState;
	var tourSubState:TourSubState;

	public var band:Band;

	public var date:DateTime;

	var dateInterval:Float = 0;

	var gameState:GameState;
	var speed = Speed.SLOW;

	var pointClicked:FlxPoint;
	var pointCamera:FlxPoint;
	var hud:HUD;
	var hudCam:FlxCamera;

	var albumTime = 0;

	var stateLabel:FlxText;

	override public function create()
	{
		super.create();

		date = DateTime.make(2000, 1, 1, 0, 0, 0);
		band = new Band();
		
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.kartenn__png);

		gameState = GameState.NORMAL;
		add(bg);
		//FlxG.camera.follow(bg, LOCKON, 1);

		hud = new HUD(this);
		add(hud);
		FlxG.camera.zoom = 0.5;
		hudCam = new FlxCamera(0, 0, hud.width, hud.height);
		hudCam.scroll.x = Main.HUDx;
		hudCam.scroll.y = Main.HUDy;
		//hudCam.zoom = 1; // For 1/2 zoom out.
		hudCam.bgColor = FlxColor.TRANSPARENT;

		//hudCam.alpha = .5;

		
		FlxG.cameras.add(hudCam);
		//FlxG.camera = FlxG.cameras.list[1];
	}



	public function clickRecordAlbum() 
	{
		if(gameState != GameState.NORMAL) {
			var popup = new SimplePopup();
			popup.quickSetup("Error", "You can't make an album while you're recording or you're on tour.", ["OK"]);
			openSubState(popup);
		} else {
			albumSubState = new AlbumSubState(this);
			albumSubState.closeCallback = albumClosed;
			openSubState(albumSubState);
		}
	}
	public function clickGoOnTour() 
	{
		if(gameState != GameState.NORMAL) {
			var popup = new SimplePopup();
			popup.quickSetup("Error", "You can't go on tour while you're recording or you're on tour.", ["OK"]);
			openSubState(popup);
		} else {
			tourSubState = new TourSubState(this);
			tourSubState.closeCallback = tourClosed;
			openSubState(tourSubState);
		}
	}

	public function albumClosed() {
		if(albumSubState.getAlbum() != null) {
			var album = albumSubState.getAlbum();
			album.releaseDate = new DateTime(date);
			band.addAlbum(album);
			band.money -= AlbumSubState.ALBUM_COST;
			gameState = GameState.MAKING_ALBUM;
			albumTime = 6;
		}

	}

	public function tourClosed() {
		if(tourSubState.getOK()) {
			band.money -= tourSubState.tourCost;
			gameState = GameState.TOURING;
		}

	}

	


	public function setSpeed(speed:Speed) {
		this.speed = speed;
		switch(speed) {
			case Speed.PAUSE:
				hud.speedLabel.text = "||";
			case Speed.SLOW:
				hud.speedLabel.text = ">";
			case Speed.FAST:
				hud.speedLabel.text = ">>";
			case Speed.VERY_FAST:
				hud.speedLabel.text = ">>>";
				
		}
	}

	public function passMonth(){
		dateInterval = 0;
		date = date.add(Month(1));
		band.money += band.getMonthlyChange(date);
		hud.dateLabel.text = date.format("%m %Y");
		if(band.popularity > 0) {
			band.popularity -= 0.5;
		}
		if(albumTime > 0) {
			albumTime-=1;
			if(albumTime == 0) {
				gameState = GameState.NORMAL;
				var popup = new SimplePopup();
				popup.quickSetup("Success", "You have published a new album!", ["OK"]);
				band.popularity += 10;
				band.expectation += 10;
				openSubState(popup);
			}
		}
		if (gameState == GameState.TOURING) {
			if(band.isStillOnTour(date)) {
				if(band.getShowForDate(date) != null) {
					band.money += 300 + (band.popularity *100);
					band.expectation += 2;
					band.popularity += 10 + band.expectation *2;
				}

			} else {
				gameState = GameState.NORMAL;
			}
			
		}
	}

	override public function update(elapsed:Float)
	{
		dateInterval+=elapsed;
		switch(speed) {
			case Speed.SLOW:
				if(dateInterval > 5) {
					passMonth();
				}
			case Speed.FAST:
				if(dateInterval > 3) {
					passMonth();
				}
			case Speed.VERY_FAST:
				if(dateInterval > 1) {
					passMonth();
				}
			case Speed.PAUSE:
				
		}


		if(FlxG.mouse.justPressed) {
			pointClicked = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
			pointCamera = new FlxPoint(FlxG.camera.scroll.x, FlxG.camera.scroll.y);
		}
		if(FlxG.mouse.pressed && FlxG.mouse.justMoved) {
			FlxG.camera.scroll.x = pointCamera.x + (pointClicked.x - FlxG.mouse.x);
			FlxG.camera.scroll.y = pointCamera.y + (pointClicked.y - FlxG.mouse.y);
		}
		if(FlxG.mouse.wheel != 0) {
			if(FlxG.camera.zoom <= 1) {
				FlxG.camera.zoom += FlxG.mouse.wheel * elapsed;
			} else {
				FlxG.camera.zoom += 2 * FlxG.mouse.wheel * elapsed;
			}
		}

		hud.money.text = "Money: $" + band.money;
		hud.popularity.text = "Popularity: " + band.popularity;
		hud.monthlyCost.text = "Monthly change: " + band.getMonthlyChange(date);
		hud.expectation.text = "Excpectation: " + band.expectation;

		if(gameState == GameState.MAKING_ALBUM) {
			hud.stateLabel.text = "RECORDING";
		} else if(gameState == GameState.TOURING) {
			hud.stateLabel.text = "TOURING...";
		} else {
			hud.stateLabel.text = "";
		}
		


		super.update(elapsed);
	}

}
