# Psuedo-lasergun

⨡ socket as NET
⮌ requests ⨡ post
⮌ threading ⨡ Thread

URL = "http://127.0.0.1:8000/api"

🟑Set a ID to a team🟑
j={ "command": "player",
    "id": 5,
    "team": "R"}
☾⨯post(URL, json=j).text

🟑Get state🟑
j={ "command": "get_state" }
֎⇒ { "stage": …,
     "teams": {
        "red": …,
        "green": … } }֎
☾⨯(j≔post(URL, json=j)).text

ADDRESS = "0.0.0.0"

sock = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
sock.sendto(b"5:2", (ADDRESS, 7501))

⊢ reader():
     (rec_sock ≔ NET.socket(NET.AF_INET, NET.SOCK_DGRAM)).bind((ADDRESS, 7500))
     ➰𝕋:
          data, (ip, port) = rec_sock.recvfrom(1024)
          ☾⨯‹Revieved data: "{data.decode()}" from {ip}:{port}›
Thread(target=reader).start()

➰𝕋:
     sock.sendto(input("Input: ").encode(), (ADDRESS, 7501))