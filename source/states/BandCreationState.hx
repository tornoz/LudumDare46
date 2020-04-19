package states;

import model.Cities;
import flixel.addons.ui.StrNameLabel;
import flixel.input.FlxInput;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.FlxState;
import model.Band;
import flixel.system.FlxSoundGroup;
import model.Album;
import model.City;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIInputText;

class BandCreationState extends FlxState
{

	private var band:Band;

	private var nameInput:FlxUIInputText;
	private var placeInput:FlxUIDropDownMenu;


	override public function create()
	{
		var validateButton = new FlxButton(200, 300, "Publish", clickPublish);
		add(validateButton);

		nameInput = new FlxUIInputText(200,200, 200, "Name of the band");

		var placeArray = [
			new StrNameLabel("Naoned", "Naoned"),
			new StrNameLabel("Paris", "Paris"),
			new StrNameLabel("New York", "New York"),
			new StrNameLabel("Toronto", "Toronto"),
			new StrNameLabel("Buenos Aires", "Buenos Aires"),
			new StrNameLabel("Montevideo", "Montevideo"),
			new StrNameLabel("Ouadadougou", "Ouadadougou"),
			new StrNameLabel("Cairo", "Cairo"),
			new StrNameLabel("Tokyo", "Tokyo"),
			new StrNameLabel("New Delhi", "New Delhi"),
			new StrNameLabel("Canberra", "Canberra")
		];
		placeInput = new FlxUIDropDownMenu(200, 250, placeArray);

		add(nameInput);
		add(placeInput);
		super.create();
	}


	public function clickPublish() {
		band = new Band();
		// band.setOrigin(new City(placeInput.selectedId, placeInput.selectedLabel));
		band.setName(nameInput.text);
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}


}
