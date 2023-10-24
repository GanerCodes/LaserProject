var redPlayers= {
    "Matthew": 10,
    "Jimmy": 12,
    "Edgar": 11,
    "GaynerCodes": 9,
};

var redTotal;

var greenPlayers= {
    "Bob": 12,
    "Billy": 11,
    "James": 10,
    "John": 8,
};

var greenTotal; 

function onPageStartTest() {
    alert("Hey man!  This is just a debug message to let you know that the script is running!");
    var i = 0;
    // Add red players to html
    for (var name in redPlayers) {
        const node = document.createElement("tr");
        const newPlayer = document.createElement("td");
        newPlayer.innerHTML = name;
        newPlayer.setAttribute("class", "border border-white p-2")
        node.appendChild(newPlayer);
        const newScore = document.createElement("td");
        newScore.innerHTML = redPlayers[name];
        newScore.setAttribute("class", "border border-white p-2 w-1/4")
        node.appendChild(newScore);

        document.getElementById("redBody").appendChild(node);

        i = i + 1;
    }
    // Add green players to html
     for (var name in greenPlayers) {
        const node = document.createElement("tr");
        const newPlayer = document.createElement("td");
        newPlayer.innerHTML = name;
        newPlayer.setAttribute("class", "border border-white p-2")
        node.appendChild(newPlayer);
        const newScore = document.createElement("td");
        newScore.innerHTML = greenPlayers[name];
        newScore.setAttribute("class", "border border-white p-2 w-1/4")
        node.appendChild(newScore);

        document.getElementById("greenBody").appendChild(node);

        i = i + 1;
    }

    // <td class="border border-white p-2">PlayerName</td>
    // <td class="border border-white p-2 w-1/4">100</td>
}

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