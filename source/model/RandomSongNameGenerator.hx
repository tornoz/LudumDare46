package model;

import flixel.math.FlxRandom;

class RandomSongNameGenerator {

    public static var first_adjective = [
        "Epic",
        "Majestic",
        "Enchanted",
        "Mighty",
        "Holy",
        "Dying",
        "Evil",
        "Mysterious",
        "Dark",
        "Last",
        "First",
        "Bloody",
        "Magic"
    ];

    public static var first_name = [
        "Rage",
        "Fury",
        "Flight",
        "Vengeance",
        "Secret",
        "Dance",
        "Journey",
        "Omen",
        "Prophecy",
        "Rhymes",
        "Pride",
        "March",
        "War",
        "Ride",
        "Dawn",
        "Nightfall"
    ];

    public static var last_name = [
        "Dwarves",
        "Unicorn",
        "Lords",
        "Elves",
        "Orcs",
        "Dragons",
        "Wizard",
        "Queen",
        "King",
        "Demons",
        "Tyrant",
        "Angels",
        "Swordmaster",
        "Gargoyles",
        "Titans",
        "Trolls",
        "Steel",
        "World"
    ];

    public static function getRandomSongName() {
        var rand =new FlxRandom();

        var number = rand.int(0,3);
        switch(number) {
            case 0:
                return theAdjNameoftheName();
            case 1:
                return adjName();
            case 2:
                return theNameoftheName();
            case 3:
                return theNameoftheAdjName();
        }
        return "";
    }

    public static function theAdjNameoftheName() {
        var rand =new FlxRandom();

        return "The "+first_adjective[rand.int(0, first_adjective.length-1)]
        + " " + first_name[rand.int(0, first_name.length-1)] + " of the "
        + last_name[rand.int(0, last_name.length-1)];
    }

    public static function adjName() {
        var rand =new FlxRandom();

        return first_adjective[rand.int(0, first_adjective.length-1)] + " "
        + last_name[rand.int(0, last_name.length-1)];
    }


    public static function theNameoftheName() {
        var rand =new FlxRandom();

        return "The "
        + first_name[rand.int(0, first_name.length-1)] + " of the "
        + last_name[rand.int(0, last_name.length-1)];
    }


    public static function theNameoftheAdjName() {
        var rand =new FlxRandom();

        return "The "
        + first_name[rand.int(0, first_name.length-1)] + " of the "
        +first_adjective[rand.int(0, first_adjective.length-1)]
        + " " + last_name[rand.int(0, last_name.length-1)];
    }
}