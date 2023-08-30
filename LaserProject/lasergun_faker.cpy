⨡ socket as NET
⮌ requests ⨡ post

URL = "http://127.0.0.1:8000/api"
☾⨯post(URL, json={
     "command": "player",
     "id": 5,
     "team": "R"}).text
☾⨯post(URL, json={
     "command": "player",
     "id": 6,
     "team": "G"}).text
☾⨯post(URL, json={
     "command": "player",
     "id": 6,
     "team": "G"}).text

☾⨯(j≔post(URL, json={
     "command": "get_state"})).text

ADDRESS = "0.0.0.0"

sock = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
sock.sendto(b"5:2", (ADDRESS, 7501))

(rec_sock ≔ NET.socket(NET.AF_INET, NET.SOCK_DGRAM)).bind((ADDRESS, 7500))
➰𝕋:
     data, (ip, port) = rec_sock.recvfrom(1024)
     ☾⨯‹Revieved data: "{data.decode()}" from {ip}:{port}›