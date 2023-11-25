⮌ socket_server ⨡ Socket_Server
⮌ time ⨡ time, sleep
⮌ collections ⨡ namedtuple as NT
⮌ threading ⨡ Thread
⮌ html ⨡ escape as 𝐡

🟑
State:
    1: Created lobby
    2: Starting game (in game loop)
    3: Started game (after 30s timeout)
    4: Concluded game
🟑
Player = ⑵ℵ(name=x, score=y, B=𝔽)
Ω Game:
    ⊢ reset_game(𝕊):
        🢖stage, 🢖teams, 🢖actions = 1, ℵ(R={}, G={}), ℵ(R=[], G=[])
        ↪𝕋
    
    ⊢ __init__(𝕊, database):
        🢖database = database
        🢖reset_game()
        🢖server = Socket_Server(🢖handle_client_message)
        Thread(target=🢖server).start() # Start TCP Server
    
    ⊢ remove_player(𝕊, team, player):
        ¿team∉🢖teams ∨ player∉(T≔🢖teams[team]): ↪
        󰆴T[player]
    
    ⊢ handle_command(𝕊, cmd):
        𝔼 = (①{"msg": x})𐞂
        ¿"command"∉cmd: ↪(400, 𝔼‹Missing command›)
        ¿cmd["command"]≡"get_state":
            ↪ (200, 🢖get_state())
        ¿cmd["command"]≡"reset_game":
            ↪ (200, 𝔼‹Reset game.›) ¿🢖reset_game()¡ (400, 𝔼‹Failed to reset game›)
        ¿cmd["command"]≡"start_game":
            ↪ (200, 𝔼‹Starting game.›) ¿🢖start_game()¡ (400, 𝔼‹Failed to start game›)
        ¿cmd["command"]≡"call_database":
            req = 🢖database(⠶cmd)
            req₁['code'] = req₀
            ↪ (req₀, req₁)
        ¿cmd["command"]≡"player":
            ¿🢖stage∉1⋄2: ↪(400, 𝔼‹Game already started!›)
            ¿"id"∉cmd: ↪(400, 𝔼‹Missing id›)
            ¿"team"∉cmd: ↪(400, 𝔼‹Missing team›)
            ¿(team≔cmd["team"].upper())∉"RGD": ↪(400, 𝔼‹Invalid team›)
            
            code, resp = 🢖database(ID=(play_id≔cmd["id"]))
            ¿code≠200: ↪(400, 𝔼‹Failed to pull player from DB: "{resp['msg']}" ›)
            play_name = resp['name']
            
            ⁅🢖remove_player(x, play_id) ∀x∈({⠤"RGD"}-{team,D❟})⁆
            ¿team≡D❟: ↪(200, 𝔼‹Success›)
            🢖teams[team][play_id] = Player(play_name, 0)
            ↪(200, 𝔼‹Added player {play_id}:{play_name}›)
        ↪(400, 𝔼‹Invalid command›)
    
    ⊢ start_game(𝕊):
        ¿🢖stage≠1: ↪
        🢖stage=2
        Thread(target=🢖game_loop).start() # Start the game loop
        ↪𝕋
    
    ⊢ game_loop(𝕊):
        ¿🢖stage≠2: ↪𝔽
        
        🢖start_time = time() + 11.75 # in game timer lasts long
        ➰🢖stage≡2: # 10s timeout 
            ¿(t≔time())<🢖start_time:
                sleep(0.1) ; ↺
            🢖stage=3
        
        🢖server.transmit("202") 🟑Start Game🟑
        🢖end_time = time() + 5⨯60
        ➰🢖stage≡3: # in-game
            ¿time() > 🢖end_time:
                🢖stage≡4 ; ⇥
            sleep(0.1)
        ∀_∈0…3: 🟑End Game🟑
            🢖server.transmit("221")
            sleep(0.1)
    
    ⊢ get_state(𝕊): # Package up gamestate
        TS = ①sorted(x.values(), key=①x.score, reverse=𝕋)
        data = { "stage": 🢖stage,
                 "teams": {
                      "red": TS(🢖teamsᴿ),
                    "green": TS(🢖teamsᴳ) },
                 "actions": {
                      "red": 🢖actionsᴿ,
                    "green": 🢖actionsᴳ } }
        ¿🢖stage≡2:
            data["start_time"] = getattr(𝕊, "start_time", ¯1)
        ⸘🢖stage≡3:
            m,s = divmod(𝒾(getattr(𝕊, "end_time", ¯1) - time()), 60)
            s = (ƨs).zfill(2)
            data["end_time"] = m⋄s
        ↪data
    
    ⊢ handle_client_message(𝕊, C, T):
        ¿🢖stage≠3: ↪
        
        ¿ C∉(players ≔ 🢖teamsᴿ|🢖teamsᴳ): ↪ # ID not on a team
        
        C_Team = 🢖teams[Tn ≔ 'GR'[C∈🢖teamsᴿ]]
        P = C_Team󰂕
        
        ⊢ u(P, 𝕥):
            ¿Tn≠𝕥: ↪
            Pᴮ=𝕋 ; P.score += 100
            
            🢖actions[Tn] += [𝒹(player=𝐡(C), target=
                ‹<text style=color:#{(⍭"F00 0F0")[𝕥≡G❟]}>{𝕥} Team</text>›)]
        ¿ T≡"53": ↪u(P,G❟)
        ⸘ T≡"43": ↪u(P,R❟)
        
        ¿ T∈C_Team:
            🢖server.transmit(C)
        ¡:
            P.score += 1 # update team score
            🢖actions[Tn] += [𝒹(player=𝐡(C), target=𝐡(T))] # add action
            🢖server.transmit(T)