var counts = { "Green": 0, "Red": 0 }
async function addPlayerToTeam(team) { // team ∈ {Green, Red}
  const T_nameText = `${team}Name`;
  const T_idText = `${team}Id`;
  const T_teamDiv = `${team}TeamDiv`;
  const T_setupInput = `${team}SetupInput`;
  let [N, I] = [VAL(T_nameText), VAL(T_idText)];

  if (!(I && counts[team] < 15)) 
    return;
  
  if(N) {
    const 𝕣 = await api({
      "command": "call_database",
      "name": N,
      "ID": I }); // add to DB
    if(𝕣['status'] != 200) return alert("NO");
  }else{
    const 𝕣 = await api({
      "command": "call_database",
      "ID": I }); // get name
    if(𝕣['status'] != 200) return alert("NO");
    N = 𝕣["name"];
  }
  
  const 𝕣 = await api({
    "command": "player",
    "id": I,
    "team": team.charAt(0)})
  if(𝕣['status'] != 200) return alert("NO");

  counts[team]++;
  const para = 
    <span class="nameIdFilled">
      <span class="textSpan"> {N} </span>
      <span class="textSpan"> {I} </span>
    </span>;

  BID(T_nameText).value = "";
  BID(T_idText).value = "";
  BID(T_teamDiv).insertBefore(para, BID(T_setupInput));
}

window.addEventListener("keydown", e => {
    if(e.keyCode != 53 || e.target.nodeName == "INPUT") return;
    e.preventDefault();
    window.location.href = "/game.html";
});
