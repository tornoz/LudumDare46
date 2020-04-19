package model;

import datetime.DateTime;

class Album
{

    private var songs:Array<Song>;

    public var quality:Float;

    public var releaseDate:DateTime;

	public function new()
    {
        songs = new Array<Song>();
    }

    public function addSong(song:Song) {
        songs.push(song);
    }

}