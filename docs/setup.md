# SmartSupport CRM Setup Guide

## 1. Prerequisites
- Salesforce Developer Edition org
- Salesforce CLI (sfdx)
- VS Code
- Python 3.10+
- Git

## 2. Clone the repository

```bash
git clone https://github.com/NamrataMargarett/smart-support-crm.git
cd smart-support-crm
```

## 3. Open in VS Code
Open the project folder in VS Code, then install the recommended extensions from `.vscode/extensions.json`.

## 4. Salesforce setup

### Authorize org

```bash
sfdx auth:web:login
```

### Deploy source

```bash
sfdx force:source:deploy -p force-app
```

### Validate metadata

```bash
sfdx force:source:deploy -p force-app --checkonly
```

## 5. Python AI service setup

```bash
cd ai-service
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload
```

## 6. Test AI prediction

```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging and the screen is black"}'
```

## 7. Recommended post-deploy checklist
- Activate Flows
- Assign permission sets
- Add user access to dashboards
- Confirm case queues exist
- Validate custom object access
- Test AI service connection from Salesforce
