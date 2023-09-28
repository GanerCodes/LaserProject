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
Player = NT("Player", ("name", "score"))
Ω Game:
    ⊢ __init__(𝕊, database):
        🢖database, 🢖stage, 🢖teams = database, 0, □
        🢖server = Socket_Server(🢖handle_client_message)
        🢖reset_game()
        Thread(target=🢖server).start() # Start TCP Server
    
    ⊢ remove_player(𝕊, team, player):
        ¿team∉🢖teams ∨ player∉(T≔🢖teams[team]): ↪   
        ␡T[player]
    
    ⊢ handle_command(𝕊, cmd):
        ¿"command"∉cmd: ↪(400, ‹Missing command›)
        ¿cmd["command"]≡"get_state":
            ↪ (200, 🢖get_state())
        ¿cmd["command"]≡"reset_game":
            ↪ (200, ‹Reset game.›) ¿🢖reset_game()¡ (400, ‹Failed to reset game›)
        ¿cmd["command"]≡"start_game":
            ↪ (200, ‹Starting game.›) ¿🢖start_game()¡ (400, ‹Failed to start game›)
        ¿cmd["command"]≡"player":
            ¿🢖stage∉1⋄2: ↪(400, ‹Game already started!›)
            ¿"id"∉cmd: ↪(400, ‹Missing id›)
            ¿"team"∉cmd: ↪(400, ‹Missing team›)
            ¿(team≔cmd["team"])∉"RGD": ↪(400, ‹Invalid team›)
            play_id = cmd["id"]
            ⁅🢖remove_player(x, play_id) ∀x∈({⠤"RGD"}-{team,D❟})⁆
            ¿team≡D❟: ↪(200, ‹Success›)
            🢖teams[team][play_id] = Player("name", 0)
            ↪(200, ‹Added player {play_id}›)
        ↪(400, ‹Invalid command›)
    
    ⊢ reset_game(𝕊):
        🢖stage, 🢖teams = 1, ℵ(R={}, G={})
        ↪𝕋
    ⊢ start_game(𝕊):
        ¿🢖stage≠1: ↪
        🢖stage=2
        Thread(target=🢖game_loop).start() # Start the game loop
        ↪𝕋
    ⊢ game_loop(𝕊):
        ¿state≠2: ↪𝔽
        
        🢖start_time = time() + 30
        ➰🢖state≡2: # 30s timeout 
            ¿t<🢖start_time:
                sleep(0.1) ; ↺
            🢖stage = 3
        ➰🢖stage≡3: # in-game
            □
    
    ⊢ get_state(𝕊): # Package up gamestate
        data = { "stage": 🢖stage,
                 "teams": {
                      "red": 🢖teams.R,
                    "green": 🢖teams.G } }
        ¿🢖stage≡2: data["start_time"] = 🢖start_time
        ↪data
    
    ⊢ handle_client_message(𝕊, C, T):
        ¿🢖stage≠3: ↪
        
        players = teams.R|teams.G
        ¿ C∉players∨T∉players: ↪ # ID not on a team
        🢖server.transmit(C)
        T = teams.R ¿C∈🢖teams.R¡ teams.G
        T[C].score += 1 # update team score
        
        # TODO: update frontend?