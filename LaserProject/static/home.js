var name;
var id;

var greenCount;
var redCount;

greenCount = 0;
redCount = 0;
document.addEventListener('keyup', function (event) { self.keyUp(event); }, false);


function test(name, id) {
  alert(name + " " + id);
}
function keyUp(event){
  if(event.keyCode ==116){//F5
  //pass playernames to go to countdown
  setTimeout(() =>window.location.href="/countdown.html", 500);
  }
  if(event.keyCode==123){//F12
    //clear all player entries
    resetToOrginal()
  }

}
function resetToOrginal(){
  //clear player entries
}
// Function for adding players using the enter button above
function addPlayerGreen(name, id) {
  // Make sure list has room and textboxes aren't empty
  if (
    document.getElementById("nameTextGreen").value != "" &&
    document.getElementById("idTextGreen").value != "" &&
    greenCount < 15
  ) {
    greenCount = greenCount + 1;
    const para = document.createElement("div");
    para.setAttribute("class", "bg-white p-4 rounded flex space-x-4");
    const node = document.createTextNode(
      "" +
        document.getElementById("nameTextGreen").value +
        "        " +
        document.getElementById("idTextGreen").value
    );
    document.getElementById("nameTextGreen").value = "";
    document.getElementById("idTextGreen").value = "";
    para.appendChild(node);

    const element = document.getElementById("greenTeamDiv");
    const child = document.getElementById("EntryBoxGreen");
    element.insertBefore(para, child);
  }
}

function addPlayerRed(name, id) {
  // Make sure list has room and textboxes aren't empty
  if (
    document.getElementById("nameTextRed").value != "" &&
    document.getElementById("idTextRed").value != "" &&
    redCount < 15
  ) {
    redCount = redCount + 1;
    const para = document.createElement("div");
    para.setAttribute("class", "bg-white p-4 rounded flex space-x-4");
    const node = document.createTextNode(
      "" +
        document.getElementById("nameTextRed").value +
        "        " +
        document.getElementById("idTextRed").value
    );
    document.getElementById("nameTextRed").value = "";
    document.getElementById("idTextRed").value = "";
    para.appendChild(node);

    const element = document.getElementById("redTeamDiv");
    const child = document.getElementById("EntryBoxRed");
    element.insertBefore(para, child);
  }
}

function redirectToCountdown() {
  window.location.href = "countdown.html";
}
