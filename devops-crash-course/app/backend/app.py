import os
from flask import Flask, jsonify
import psycopg2
from psycopg2.extras import RealDictCursor

app = Flask(__name__)

def get_db():
    host = os.environ.get("DB_HOST", "localhost")
    port = os.environ.get("DB_PORT", "5432")
    name = os.environ.get("DB_NAME", "appdb")
    user = os.environ.get("DB_USER", "appuser")
    password = os.environ.get("DB_PASSWORD", "apppass")
    return psycopg2.connect(
        host=host, port=port, dbname=name, user=user, password=password,
        cursor_factory=RealDictCursor
    )

@app.route("/health")
def health():
    return jsonify({"status": "ok", "service": "backend"})

@app.route("/api/health")
def api_health():
    return jsonify({"status": "ok"})

@app.route("/api/items")
def items():
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT id, name FROM items ORDER BY id")
        rows = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify([dict(r) for r in rows])
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
