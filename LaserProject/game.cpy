⮌ socket_server ⨡ Socket_Server
⮌ time ⨡ time, sleep
⮌ collections ⨡ namedtuple as NT
⮌ threading ⨡ Thread

🟑
State:
    0: Pre-start
    1: Created lobby
    2: Starting game (in game loop)
    3: Started game (after 30s timeout)
    4: Concluded game
🟑
Player = ⑵ℵ(name=x, score=y)
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
        ␡T[player]
    
    ⊢ handle_command(𝕊, cmd):
        𝔼 = OP_UNARY_(⑴{"msg": x}, ⠶par_mul_)
        ¿"command"∉cmd: ↪(400, 𝔼⨯‹Missing command›)
        ¿cmd["command"]≡"get_state":
            ↪ (200, 🢖get_state())
        ¿cmd["command"]≡"reset_game":
            ↪ (200, 𝔼⨯‹Reset game.›) ¿🢖reset_game()¡ (400, 𝔼⨯‹Failed to reset game›)
        ¿cmd["command"]≡"start_game":
            ↪ (200, 𝔼⨯‹Starting game.›) ¿🢖start_game()¡ (400, 𝔼⨯‹Failed to start game›)
        ¿cmd["command"]≡"call_database":
            req = 🢖database(⠶cmd)
            req₁['code'] = req₀
            ↪ (req₀, req₁)
        ¿cmd["command"]≡"player":
            ¿🢖stage∉1⋄2: ↪(400, 𝔼⨯‹Game already started!›)
            ¿"id"∉cmd: ↪(400, 𝔼⨯‹Missing id›)
            ¿"team"∉cmd: ↪(400, 𝔼⨯‹Missing team›)
            ¿(team≔cmd["team"].upper())∉"RGD": ↪(400, 𝔼⨯‹Invalid team›)
            
            code, resp = 🢖database(ID=(play_id≔cmd["id"]))
            ¿code≠200: ↪(400, 𝔼⨯‹Failed to pull player from DB: "{resp['msg']}" ›)
            play_name = resp['name']
            
            ⁅🢖remove_player(x, play_id) ∀x∈({⠤"RGD"}-{team,D❟})⁆
            ¿team≡D❟: ↪(200, 𝔼⨯‹Success›)
            🢖teams[team][play_id] = Player(play_name, 0)
            ↪(200, 𝔼⨯‹Added player {play_id}:{play_name}›)
        ↪(400, 𝔼⨯‹Invalid command›)
    
    ⊢ start_game(𝕊):
        ¿🢖stage≠1: ↪
        🢖stage=2
        Thread(target=🢖game_loop).start() # Start the game loop
        ↪𝕋
    
    ⊢ game_loop(𝕊):
        ¿🢖stage≠2: ↪𝔽
        
        🢖start_time = time() + 10
        ➰🢖stage≡2: # 10s timeout 
            ¿(t≔time())<🢖start_time:
                sleep(0.1) ; ↺
            🢖stage = 3
        ➰🢖stage≡3: # in-game
            # do stuff
            sleep(0.1)
    
    ⊢ get_state(𝕊): # Package up gamestate
        data = { "stage": 🢖stage,
                 "teams": {
                      "red": 🢖teams.R,
                    "green": 🢖teams.G },
                 "actions": {
                      "red": 🢖actions.R,
                    "green": 🢖actions.G } }
        ¿🢖stage≡2:
            data["start_time"] = getattr(𝕊, 'start_time', ¯1)
        ↪data
    
    ⊢ handle_client_message(𝕊, C, T):
        ¿🢖stage≠3: ↪
        
        players = 🢖teams.R|🢖teams.G
        ¿ C∉players∨T∉players: ↪ # ID not on a team
        🢖server.transmit(C)
        T = 🢖teams[Tn ≔ 'GR'[C∈🢖teams.R]]
        
        T[C].score += 1 # update team score
        🢖actions[Tn] += [𝒹(player=C, target=T)] # add action