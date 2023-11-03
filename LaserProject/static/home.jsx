var counts = { "Green": 0, "Red": 0 }
async function addPlayerToTeam(team, ID, NAME) {
    // team ∈ {Green, Red}
    const T_nameText = `${team}Name`;
    const T_idText = `${team}Id`;
    const T_teamDiv = `${team}TeamDiv`;
    const T_setupInput = `${team}SetupInput`;
    let [N, I] = ID ? [ID, NAME] : [VAL(T_nameText), VAL(T_idText)]

    if (!(I && counts[team] < 15)) return;

    if(!ID) {
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
            N = 𝕣["name"]; }

        const 𝕣 = await api({
            "command": "player",
            "id": I,
            "team": team.charAt(0)})
        if(𝕣['status'] != 200) return alert("NO"); }

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

const startGame = async _ => {
    await api({"command": "start_game"});
    window.location.href = "/countdown.html";
};

window.addEventListener("keydown", async e => {
    if(e.target.nodeName == "INPUT" || ![53, 57].includes(e.keyCode)) return;
    e.preventDefault();
    
    if(e.keyCode == 53) {
        startGame();
    } else {
        await api({"command": "reset_game"});
        resetTeamsLocal(); } });

const resetTeamsLocal = _ => {
    counts = { "Green": 0, "Red": 0 }
    QSA(".nameIdFilled").forEach(x => x.remove()); }

const pullTeamsFromServer = async _ => {
    const teams = (await api({"command": "get_state"}))['teams'];
    resetTeamsLocal();
    enobj(teams['green']).forEach(([k, v]) => 
        addPlayerToTeam("Green", k, v.name));
    enobj(teams['red']).forEach(([k, v]) => 
        addPlayerToTeam("Red", k, v.name)); }

window.addEventListener("load", pullTeamsFromServer);