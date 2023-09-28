🟑 Note: This file is to only be ran on the backend server. 🟑

»__name__≡"__main__"

⨡ os
⮌ flask ⨡ *
⮌ waitress ⨡ serve as w_serve
⮌ sqlitedict ⨡ SqliteDict

app = Flask(__name__)

@app.route("/database", methods=["POST"])
⊢ on_post():
    data = request.get_json()
    ☾⨯data
    ¿¬data∨¬(ID≔data.get("ID")): # All database requests need an ID
        ↪ jsonify({"error": "Invalid"}), 404
    
    with SqliteDict("database.db") as db:
        ¿name≔data.get("name"): # Set name
            db[ID] = name
            db.commit()
            ↪ jsonify({ "msg": "success" }), 200
        ⸘ID∈db: # Return name
            ↪ jsonify({ "msg": "success", "name": db[ID] }), 200
        ¡:
            ↪ jsonify({ "msg": "Player not found" }), 400

w_serve(app, listen="*:7000", clear_untrusted_proxy_headers=𝕋)
