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
    ¿¬data∨¬(ID≔data.get("ID")):
        ↪ jsonify({"error": "Invalid"}), 404
    
    with SqliteDict("database.db") as db:
        ¿name≔data.get("name"):
            db[ID] = name
            db.commit()
            ↪ jsonify({ "msg": "success" }), 200
        ⸘ID∈db: 
            ↪ jsonify({ "msg": "success", "name": db[ID] }), 200
        ¡:
            ↪ jsonify({ "msg": "Player not found" }), 400

w_serve(app, listen="*:7000", clear_untrusted_proxy_headers=𝕋)
