# SmartSupport Web App

## Overview
This is a standalone web application version of the SmartSupport CRM project without Salesforce dependencies.

## Features
- Login page
- Sign up page
- Dashboard layout
- User authentication using SQLite
- Standalone deployment

## Run Locally
```bash
cd webapp
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

Then open:
```text
http://localhost:5000
```

## Default Flow
1. Open the login page
2. Create an account on sign up page
3. Log in with your created credentials
4. View the dashboard

## Notes
This is a demo app for college/project use and is not production-grade security.
