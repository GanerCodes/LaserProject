⮌ requests ⨡ post

DATABASE_URL = "https://laserdatabase.ganer.xyz/database"
Ω Database:
    ⊢ __call__(𝕊, ⠶𝕂):
        req = post(DATABASE_URL, json=𝕂)
        ↪ req.status_code, req.json()
database = Database()