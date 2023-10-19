# Psuedo-lasergun

⨡ socket as NET
⮌ requests ⨡ post
⮌ threading ⨡ Thread

ADDRESS = "0.0.0.0"
URL = "http://127.0.0.1:8000/api"
DATABASE_URL = "https://laserdatabase.ganer.xyz/database"
⊢ Print_DB_Command(⠶𝕂):
     ☾("Print_DB_Command:", post(DATABASE_URL, json=dict(⠶𝕂)).text)
⊢ Print_Srv_Command(⠶𝕂):
     ☾("Print_Srv_Command:", post(URL, json=dict(𝕂)).text)

# Direct database commands
# Search for ID not in DB
Print_DB_Command(ID="1234")
# Add ID and name to DB
Print_DB_Command(ID="1234", name="Joe")
# Search for ID (now in DB)
Print_DB_Command(ID="1234")

🟑Call database🟑
Print_Srv_Command(
     command='call_database', ID='929')
Print_Srv_Command(
     command='call_database', ID='929', name="among")
Print_Srv_Command(
     command='call_database', ID='929')

🟑Set a ID to a team🟑
Print_Srv_Command(
     command="player",
     id="59",
     team='R')
🟑For real this time🟑
Print_Srv_Command(
     command="player",
     id="929",
     team='R')

🟑Get state🟑
Print_Srv_Command(command="get_state")

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