package model;

import flixel.math.FlxPoint;

class Place
{
    var name:String;

    var attendance:Int;

    var place:FlxPoint;

    public function new(name:String)
    {
        this.name = name;
    }
}