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

const update = async _ => {
    const state = (await api({"command": "get_state"}));
    
    print("Got state", state);
    enobj(state["teams"]).forEach(([k,v]) =>
        BID(`${k}Body`).replaceChildren(...enobj(v).map(
            ([k,v]) => makePlayerMemberElm(v.name, v.score))));
    enobj(state["actions"]).forEach(([k,v]) =>
        BID(`${k}Hits`).replaceChildren(
            ...v.map(v => makeHitElm(v.player, v.target))));
}
window.addEventListener("load", _ => setInterval(update, 1000));