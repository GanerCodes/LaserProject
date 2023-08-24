⮌ socket_server ⨡ Socket_Server
⮌ Database ⨡ database
⮌ time ⨡ time, sleep
⮌ collections ⨡ namedtuple as NT

🟑
State:
    0: Pre-start
    1: Created lobby
    2: Starting game (in game loop)
    3: Started game (after 30s timeout)
    4: Concluded game
🟑
Player = NT("Player", "addr", "score")
cls Game:
    ⊢ __init__(𝕊, database):
        🢖database, 🢖state, 🢖teams = database, 0, □
        🢖server = Socket_Server(🢖handle_client_message)
        Thread(target=socket_server).start()
    
    ⊢ create_game(𝕊):
        🢖stage, 🢖teams = 1, ℵ(R={}, G={})
        ↪𝕋
    ⊢ start_game(𝕊):
        ¿🢖stage≠1: ↪
        🢖stage=2
        Thread(target=🢖game_loop).start()
        ↪𝕋
    ⊢ game_loop(𝕊):
        ¿state≠2: ↪𝔽
        
        start_time = time() + 30
        ➰🢖state≡2: # 30s timeout 
            ¿t<start_time:
                sleep(0.1) ; ↺
            🢖stage = 3
        ➰🢖stage≡3: # game
            □
    
    ⊢ handle_client_message(𝕊, C, T):
        ¿🢖stage≠3: ↪
        players = teams.R|teams.G
        ¿ C∉players∨T∉players: ↪
        # TODO: what do i do here lol