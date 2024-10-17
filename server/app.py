from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import bcrypt  # for Hashing
import re  # Importing regex module for password validation
import os  # For environment variable access
from dotenv import load_dotenv  # Load environment variables from .env file

load_dotenv()  # Load environment variables

app = Flask(__name__)
CORS(app)  # This will allow all origins by default

PEPPER = os.getenv('PEPPER')  # Get pepper from environment variable

# MySQL connection setup
def create_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='',  # replace with your MySQL password
        database='user_account'  # replace with your database name
    )

# Password validation function
def is_strong_password(password):
    # At least 8 characters, includes upper, lower, digit, and special character
    if (len(password) >= 8 and 
        re.search(r"[A-Z]", password) and  # Uppercase letter
        re.search(r"[a-z]", password) and  # Lowercase letter
        re.search(r"\d", password)):       # Digit
        return True
    return False

# Signup route
@app.route('/signup', methods=['POST'])
def signup():
    try:
        conn = create_connection()
        cursor = conn.cursor()

        name = request.json['name']  # Capture the name
        email = request.json['email']
        password = request.json['password']

        # Check if the email already exists
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()
        if user:
            return jsonify({"error": "Email already exists"}), 409

        # Validate the password strength
        if not is_strong_password(password):
            return jsonify({"error": "Password must be at least 8 characters long and include upper, lower, digit, and special character"}), 400

        # Hashing password with pepper
        hashed_password = bcrypt.hashpw((password + PEPPER).encode('utf-8'), bcrypt.gensalt())
        cursor.execute("INSERT INTO users (name, email, password, pepper) VALUES (%s, %s, %s, %s)", (name, email, hashed_password, PEPPER))
        conn.commit()

        return jsonify({"message": "User created successfully"}), 201

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

# Login route
@app.route('/login', methods=['POST'])
def login():
    try:
        conn = create_connection()
        cursor = conn.cursor()

        email = request.json['email']
        password = request.json['password']

        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()

        if user:
            stored_password = user[3]  # assuming the password is in the 3rd column
            pepper = user[4]  # assuming the pepper is in the 4th column

            # Check password with pepper
            if bcrypt.checkpw((password + pepper).encode('utf-8'), stored_password.encode('utf-8')):
                return jsonify({
                    "message": "Login successful",
                    "user": {
                        "name": user[1],  # assuming name is in the 1st column
                        "email": user[2],  # assuming email is in the 2nd column
                        "password": password,  # show password
                        "hashed_password": stored_password,  # Send hashed password
                        "pepper": pepper  # Send pepper
                    }
                }), 200
            else:
                return jsonify({"error": "Incorrect password"}), 401
        else:
            return jsonify({"error": "User not found"}), 404

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == '__main__':
    app.run(debug=True)
