package model;

import datetime.DateTime;

class Show
{
    var name:String;

    var attendance:Int;

    public var place:String;
    public var date:DateTime;

    public function new(?name:String)
    {
        this.name = name;
    }


}