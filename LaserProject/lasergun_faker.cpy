⨡ socket as NET

ADDRESS = "0.0.0.0"

sock = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
sock.sendto(b"5:2", (ADDRESS, 7501))

(rec_sock ≔ NET.socket(NET.AF_INET, NET.SOCK_DGRAM)).bind((ADDRESS, 7500))
➰𝕋:
     data, (ip, port) = rec_sock.recvfrom(1024)
     ☾⨯‹Revieved data: "{data.decode()}" from {ip}:{port}›