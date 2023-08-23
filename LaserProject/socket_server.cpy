⨡ socket

cls Socket_Server:
    PORT_B, PORT_R = 7500, 7501
    ⊢ socket_server(𝕊):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind(("127.0.0.1", 🢖PORT_B))

        ➰𝕋:
            data, addr = sock.recvfrom(1024)
            S, T = int|ᴍ|data.split(:❟,1)
            ☾⨯data⋄addr