const makePlayerMemberElm = (n, s, B) => 
    (<tr>
        <td class="border border-white p-2 text-white">
            <text class="text-bold text-red"
                  style={`font-weight:bold;color:#99F;display:${B?"":"none"}`}> ℬ </text>
            <text> {n} </text>
        </td>
        <td class="border border-white p-2 w-1/4 text-white"> {s} </td>
    </tr>);
    
const makeHitElm = (n, t) => 
    (<tr>
        <td class="border border-white p-2 text-white">{n}</td>
        <td HTML={t} class="border border-white p-2 w-1/4 text-white"></td>
    </tr>);

const makeTopPlayerMemberElm = (n, s) => 
    (<p1>
        <div class="text-sm font-semibold text-white mb-4"> Player: {n} | Score: {s} </div>
    </p1>);


const update = async _ => {
    const state = (await api({"command": "get_state"}));
    
    print("Got state", state);
    const scores = {};
    enobj(state["teams"]).forEach(([k,v]) =>
        BID(`${k}Body`).replaceChildren(...enobj(v).map(
            ([k,v]) => makePlayerMemberElm(v.name, scores[v.name]=v.score, v.B))));
    enobj(state["actions"]).forEach(([k,v]) =>
        BID(`${k}Hits`).replaceChildren(
            ...v.map(v => makeHitElm(v.player, v.target))));
    
    const [rTot, gTot] = enobj(state["teams"])
        .map(([_,V]) => 
            enobj(V)
                .map(([k,v]) => v.score)
                .reduce((x,y)=>x+y, 0));
    
    BID("totalStatus").replaceChildren(
        <div >{rTot}</div>,
        <div>|</div>,
        <div >{gTot}</div>);
    
    const [h,s] = state["end_time"];
    BID("timeDisplay").innerHTML = `${h}:${s}`;
    
    let topScores = enobj(scores);
    sort(topScores, (x=>x[1]), 𝕋);
    BID("topPlayers").replaceChildren(...(topScores.slice(0,3)).map(x => makeTopPlayerMemberElm(...x)));
}
window.addEventListener("load", _ => setInterval(update, 1000));