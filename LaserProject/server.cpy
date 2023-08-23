⨡ os
⮌ werkzeug.security ⨡ safe_join
⮌ flask ⨡ *

cls Reply:
    ⊢ __getattr__(𝕊, name):
        match name:
            case "ok":
                ↪ Response(status=200)
            case "error404":
                ↪ jsonify({"error": "Not found"}), 404
            case "errorCringe":
                ↪ jsonify({"error": "L+ratio+you fell off"}), 500
Reply = Reply()

app = Flask(__name__)

@app.route(/❟, defaults={"path": ᐦ})
@app.route("/<path:path>")
⊢ route(path):
    ¿ path ∈ "/": path = "index.html"
    path = safe_join(app.static_folder, path)
    ¿ path ≡ □: ↪ Reply.errorCringe
    ¿ os.path.isfile(path): ↪ send_file(path)
    ⸘ os.path.isdir(path): ↪ jsonify(os.path.listdir(path))
    ↪ Reply.error404

¿ __name__ ≠ "__main__": exit()

app.run(host="0.0.0.0", port="8000")