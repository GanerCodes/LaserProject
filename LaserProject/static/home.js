var name;
var id;

var greenCount;
var redCount;

greenCount = 0;
redCount = 0;

function test(name, id) {
  alert(name + " " + id );
}

// Function for adding players using the enter button above
function addPlayerGreen(name, id) {
    // Make sure list has room and textboxes aren't empty
    if ((document.getElementById('nameTextGreen').value != "") && (document.getElementById('idTextGreen').value != "") && (greenCount < 15)) {
        greenCount = greenCount + 1;
        const para = document.createElement("div");
        para.setAttribute("class", "bg-white p-4 rounded flex space-x-4")
        const node = document.createTextNode("" + document.getElementById('nameTextGreen').value + "        " + document.getElementById('idTextGreen').value);
        document.getElementById('nameTextGreen').value = "";
        document.getElementById('idTextGreen').value = "";
        para.appendChild(node);
        
        const element = document.getElementById("greenTeamDiv");
        const child = document.getElementById("EntryBoxGreen")
        element.insertBefore(para, child);
    }
  }

  function addPlayerRed(name, id) {
    // Make sure list has room and textboxes aren't empty
if ((document.getElementById('nameTextRed').value != "") && (document.getElementById('idTextRed').value != "") && (redCount < 15)) {
redCount = redCount + 1;
const para = document.createElement("div");
para.setAttribute("class", "bg-white p-4 rounded flex space-x-4")
const node = document.createTextNode("" + document.getElementById('nameTextRed').value + "        " + document.getElementById('idTextRed').value);
document.getElementById('nameTextRed').value = "";
document.getElementById('idTextRed').value = "";
para.appendChild(node);

const element = document.getElementById("redTeamDiv");
const child = document.getElementById("EntryBoxRed")
element.insertBefore(para, child);
}
}