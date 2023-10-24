var redPlayers= {
    "Matthew": 10,
    "Jimmy": 12,
    "Edgar": 11,
    "GaynerCodes": 9,
    "Amber": 10
};

var redTotal;

var greenPlayers= {
    "Bob": 12,
    "Billy": 11,
    "James": 10,
    "John": 8,
    "Karl": 13
};

var greenTotal; 

function testRed () {
    redTotal = 0;
    for (var name in redPlayers) {
        console.log("Name: " + name + ", Score: " + redPlayers[name]);
        redTotal = redTotal + redPlayers[name];
    }
    console.log("Total Red Score: " + redTotal);
}

function testGreen () {
    greenTotal = 0;
    for (var name in greenPlayers) {
        console.log("Name: " + name + ", Score: " + greenPlayers[name]);
        greenTotal = greenTotal + greenPlayers[name];
    }
    console.log("Total Green Score: " + greenTotal);
}