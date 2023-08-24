⨡ socket as NET

cls Socket_Server:
    ADDRESS = "0.0.0.0"
    PORT_B, PORT_R = 7500, 7501
    
    ⊢ __init__(𝕊, handler):
        🢖Sock_B = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
        (🢖Sock_R ≔ NET.socket(NET.AF_INET, NET.SOCK_DGRAM)).bind((🢖ADDRESS, 🢖PORT_R))
        🢖Clients = {}
        🢖handle_client_message = handler
    
    ⊢ transmit(𝕊, data, target=□):
        ☾⨯🢖Clients
        B = ⑴🢖Sock_B.sendto(data.encode(), (x, 🢖PORT_B))
        B(target) ¿target¡ ⁅B(c)∀c∈🢖Clients.values()⁆
    
    ⊢ __call__(𝕊):
        ➰𝕋:
            data, (ip, port) = 🢖Sock_R.recvfrom(1024)
            C, T = data.decode().split(:❟,1)
            ¿C∉🢖Clients:
                🢖Clients[C] = ip
                ☾⨯‹Added client {C} - {ip}›
            ⸘(p≔🢖Clients[C])≠ip:
                🢖Clients[C] = ip
                ☾⨯‹Changed {C}'s IP: {p}→{ip}›
            ☾⨯‹{C}:{T}›
            🢖handle_client_message(C, T)