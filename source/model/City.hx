package model;

import flixel.addons.ui.StrNameLabel;
import flixel.math.FlxPoint;

class City extends StrNameLabel
{
    public var place:FlxPoint;

    public var continent:String;

    public function new(name:String, label:String, continent:String, ?place:FlxPoint)
    {
        super(name, label);
        this.place = place;
        this.continent = continent;
    }
}