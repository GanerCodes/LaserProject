⮌ requests ⨡ post
DATABASE_URL = "https://laserdatabase.ganer.xyz/database"
⊢ Print_DB_Command(⠶𝕂):
    ☾⨯post(DATABASE_URL, json=dict(⠶𝕂)).text

# Search for ID not in DB
Print_DB_Command(ID="1234")
# Add ID and name to DB
Print_DB_Command(ID="1234", name="Joe")
# Search for ID (now in DB)
Print_DB_Command(ID="1234")