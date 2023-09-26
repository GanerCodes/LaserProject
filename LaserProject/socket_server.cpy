⨡ socket as NET

cls Socket_Server:
    ADDRESS = "0.0.0.0"
    PORT_B, PORT_R = 7500, 7501 # Broadcast, Recieve
    
    ⊢ __init__(𝕊, handler):
        🢖Sock_B = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
        (🢖Sock_R ≔ NET.socket(NET.AF_INET, NET.SOCK_DGRAM)).bind((🢖ADDRESS, 🢖PORT_R))
        🢖Clients = {}
        🢖handle_client_message = handler
    
    reset_clients = 𝕊↦(🢖Clients≔{})
    
    ⊢ transmit(𝕊, data, target=□):
        B = ⑴🢖Sock_B.sendto(data.encode(), (x, 🢖PORT_B))
        # Default broadcast, if given a target send message to client uniquely
        B(target) ¿target¡ ⁅B(c)∀c∈🢖Clients.values()⁆
    
    ⊢ __call__(𝕊):
        ➰𝕋: # TCP server loop
            data, (ip, port) = 🢖Sock_R.recvfrom(1024)
            ☾⨯‹Laser says: {data}›
            ¿ :❟∉(data≔data.decode()): # malformed input
                ☾⨯‹Unable to process: "{data}\"› ; ↺
            
            C, T = data.split(:❟,1) # Shooter ID, target ID
            ¿C∉🢖Clients:
                🢖Clients[C] = ip
                ☾⨯‹Added client {C} - {ip}›
            ⸘(p≔🢖Clients[C])≠ip:
                🢖Clients[C] = ip
                ☾⨯‹Changed {C}'s IP: {p}→{ip}›
            🢖handle_client_message(C, T)