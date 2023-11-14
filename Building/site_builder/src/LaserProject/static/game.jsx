const makePlayerMemberElm = (n, s) => 
    (<tr>
        <td class="border border-white p-2 text-white"> {n} </td>
        <td class="border border-white p-2 w-1/4 text-white"> {s} </td>
    </tr>);

const update = async _ => {
    const state = (await api({"command": "get_state"}));
    const teams = state["teams"];
    enobj(teams).forEach(([k,v]) =>
        BID(`${k}Body`).replaceChildren(...enobj(v).map(
            ([k,v]) => makePlayerMemberElm(...v))));
    
    print(state)
}
window.addEventListener("load", _ => setInterval(update, 1000));