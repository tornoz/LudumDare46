package model;

import flixel.addons.ui.FlxUIColorSwatch;
import datetime.DateTime;

class Band
{


    var albums:Array<Album>;
    var shows:Array<Show>;
    var name:String;
    var origin:City;

    public var money:Float;
    public var popularity:Float;
    public var monthlyCost:Float;

    public var expectation:Float;

	public function new()
    {
        albums = new Array<Album>();
        shows = new Array<Show>();
        money = 10000;
        popularity = 0;
        monthlyCost = 200;
        expectation = 0;
    }

    public function addAlbum(album:Album) {
        albums.push(album);
    }

    public function setOrigin(city:City) {
        this.origin = city;
    }
    public function getOrigin(city:City) : City {
        return this.origin;
    }
    public function setName(name:String) {
        this.name = name;
    }

    public function addShow(show:Show) {
        shows.push(show);
    }
    public function getUpcomingShow(date:DateTime) {
        var upcomingShows = new Array<Show>();
        for(show in shows) {
            if(show.date > date) {
                upcomingShows.push(show);
            }
        }
        return upcomingShows;
    }

    public function getMonthlyChange(now:DateTime) 
    {
        var change = -200.0;
        for(album in albums) {
            change += Math.max(0, (12-(now - (album.releaseDate.add(Month(6)))).getTotalMonths())*popularity*5);
        }
        return change;
    }

    public function getShowForDate(date:DateTime) {
        for(show in shows) {
            if(show.date == date) {
                return show;
            }
        }
        return null;
    }
    public function isStillOnTour(date:DateTime) {
        for(show in shows) {
            if(show.date > date) {
                return true;
            }
        }
        return false;

    }

}