const makePlayerMemberElm = (n, s) => 
    (<tr>
        <td class="border border-white p-2 text-white"> {n} </td>
        <td class="border border-white p-2 w-1/4 text-white"> {s} </td>
    </tr>);
    
const makeHitElm = (n, t) => 
    (<tr>
        <td class="border border-white p-2 text-white"> {n} </td>
        <td class="border border-white p-2 w-1/4 text-white"> {t} </td>
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
            ([k,v]) => makePlayerMemberElm(v.name, scores[v.name]=v.score))));
    enobj(state["actions"]).forEach(([k,v]) =>
        BID(`${k}Hits`).replaceChildren(
            ...v.map(v => makeHitElm(v.player, v.target))));
    
    let topScores = enobj(scores);
    sort(topScores, (x=>x[1]), 𝕋);
    BID("topPlayers").replaceChildren(...(topScores.slice(0,3)).map(x => makeTopPlayerMemberElm(...x)));
}
window.addEventListener("load", _ => setInterval(update, 1000));