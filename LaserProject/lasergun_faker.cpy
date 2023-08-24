⨡ socket as NET

ADDRESS = "0.0.0.0"

sock = NET.socket(NET.AF_INET, NET.SOCK_DGRAM)
sock.sendto(b"5:2", (ADDRESS, 7501))