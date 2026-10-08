from flask import Flask, render_template, request, redirect, url_for, session
import sqlite3
import os

app = Flask(__name__)
app.secret_key = "smartsupport-demo-secret-key"

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "users.db")


def get_db_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def init_db():
    conn = get_db_connection()
    conn.execute(
        """
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
        )
        """
    )
    conn.execute(
        """
        CREATE TABLE IF NOT EXISTS complaints (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT NOT NULL,
            email TEXT NOT NULL,
            category TEXT NOT NULL,
            customer_type TEXT NOT NULL DEFAULT 'Standard',
            priority TEXT NOT NULL,
            severity TEXT NOT NULL,
            description TEXT NOT NULL,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
        """
    )
    conn.commit()
    conn.close()


def calculate_priority(category, customer_type, description):
    text = f"{category} {customer_type} {description}".lower()
    score = 0

    category_weight = {
        "billing": 2,
        "shipping": 1,
        "hardware": 1,
        "software": 1,
        "account": 1,
    }
    score += category_weight.get(category.lower(), 0)

    if customer_type.lower() in ["premium", "enterprise"]:
        score += 1

    urgent_words = [
        "urgent", "critical", "security", "outage", "failed payment",
        "refund", "cannot access", "not working", "down", "urgent issue",
        "fraud", "breach"
    ]
    if any(word in text for word in urgent_words):
        score += 3

    if any(word in text for word in ["error", "issue", "failed", "delay", "lost", "blocked"]):
        score += 1

    if score >= 5:
        return "High"
    elif score >= 3:
        return "Medium"
    return "Low"


init_db()


@app.route("/")
def home():
    if "user_id" in session:
        return redirect(url_for("dashboard"))
    return redirect(url_for("login"))


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"].strip()
        password = request.form["password"].strip()

        conn = get_db_connection()
        user = conn.execute(
            "SELECT * FROM users WHERE username = ? AND password = ?",
            (username, password),
        ).fetchone()
        conn.close()

        if user:
            session["user_id"] = user["id"]
            session["username"] = user["username"]
            return redirect(url_for("dashboard"))

        return render_template("login.html", error="Invalid username or password.")

    return render_template("login.html")


@app.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        username = request.form["username"].strip()
        email = request.form["email"].strip()
        password = request.form["password"].strip()
        confirm = request.form["confirm_password"].strip()

        if not username or not email or not password:
            return render_template("signup.html", error="All fields are required.")

        if password != confirm:
            return render_template("signup.html", error="Passwords do not match.")

        conn = get_db_connection()
        try:
            conn.execute(
                "INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
                (username, email, password),
            )
            conn.commit()
        except sqlite3.IntegrityError:
            conn.close()
            return render_template("signup.html", error="Username or email already exists.")

        conn.close()
        return redirect(url_for("login"))

    return render_template("signup.html")


@app.route("/complaints", methods=["GET", "POST"])
def complaints():
    if "user_id" not in session:
        return redirect(url_for("login"))

    if request.method == "POST":
        customer_name = request.form["customer_name"].strip()
        email = request.form["email"].strip()
        category = request.form["category"].strip()
        customer_type = request.form["customer_type"].strip() or "Standard"
        severity = request.form["severity"].strip()
        description = request.form["description"].strip()

        if not customer_name or not email or not category or not description:
            conn = get_db_connection()
            complaints_list = conn.execute(
                "SELECT * FROM complaints ORDER BY created_at DESC"
            ).fetchall()
            conn.close()
            return render_template(
                "complaints.html",
                error="Please complete all required fields.",
                complaints=complaints_list,
            )

        priority = calculate_priority(category, customer_type, description)

        conn = get_db_connection()
        conn.execute(
            """
            INSERT INTO complaints (customer_name, email, category, customer_type, priority, severity, description)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """,
            (customer_name, email, category, customer_type, priority, severity, description),
        )
        conn.commit()
        conn.close()

        return redirect(url_for("dashboard"))

    conn = get_db_connection()
    complaints_list = conn.execute(
        "SELECT * FROM complaints ORDER BY created_at DESC"
    ).fetchall()
    conn.close()
    return render_template("complaints.html", complaints=complaints_list)


@app.route("/dashboard")
def dashboard():
    if "user_id" not in session:
        return redirect(url_for("login"))

    username = session.get("username", "User")
    conn = get_db_connection()
    complaints_list = conn.execute(
        "SELECT * FROM complaints ORDER BY created_at DESC LIMIT 8"
    ).fetchall()
    total_cases = conn.execute("SELECT COUNT(*) AS count FROM complaints").fetchone()["count"]
    high_priority = conn.execute("SELECT COUNT(*) AS count FROM complaints WHERE priority = 'High'").fetchone()["count"]
    medium_priority = conn.execute("SELECT COUNT(*) AS count FROM complaints WHERE priority = 'Medium'").fetchone()["count"]
    low_priority = conn.execute("SELECT COUNT(*) AS count FROM complaints WHERE priority = 'Low'").fetchone()["count"]
    category_data = conn.execute(
        "SELECT category, COUNT(*) AS count FROM complaints GROUP BY category ORDER BY count DESC"
    ).fetchall()
    conn.close()

    metrics = {
        "total_cases": total_cases,
        "high_priority": high_priority,
        "medium_priority": medium_priority,
        "low_priority": low_priority,
        "category_data": category_data,
    }
    return render_template("dashboard.html", username=username, metrics=metrics, complaints=complaints_list)


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
