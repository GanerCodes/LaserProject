(async _ => {
    const songs = await api({"command": "get_songs"});
    const musicElm = BID("musicPlayer");
    const playSong = _ => {
        const song = songs[Math.floor(Math.random() * songs.length)];
        musicElm.src = song;
        musicElm.play(); };
    musicElm.addEventListener("ended", playSong, false);
    playSong();
})();

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

// https://stackoverflow.com/a/54024653
const hsv2rgb = (h,s,v,f=(n,k=(n+h/60)%6)=>v-v*s*Math.max(Math.min(k,4-k,1),0))=>[f(5),f(3),f(1)];

[rTot, gTot] = [0, 0];
setInterval(_ => {
    const RGB = hsv2rgb((+new Date() / 5.95) % 360, 1.0, 1.0).map(x=>255*x);
    const c = [`color:#FFF`, `color:rgb(${RGB[0]},${RGB[1]},${RGB[2]})`];
    BID("totalStatus").replaceChildren(
        <div style={c[+(rTot>=gTot)]}>{rTot}</div>,
        <div>|</div>,
        <div style={c[+(gTot>=rTot)]}>{gTot}</div>) },
    60 / 1000);

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
    
    [rTot, gTot] = enobj(state["teams"])
        .map(([_,V]) => 
            enobj(V)
                .map(([k,v]) => v.score)
                .reduce((x,y)=>x+y, 0));
    
    const [h,s] = state["end_time"];
    BID("timeDisplay").innerHTML = `${h}:${s}`;
    
    let topScores = enobj(scores);
    sort(topScores, (x=>x[1]), 𝕋);
    BID("topPlayers").replaceChildren(...(topScores.slice(0,3)).map(x => makeTopPlayerMemberElm(...x)));
}
window.addEventListener("load", _ => setInterval(update, 1000));