# Setup Guide

## Prerequisites
- Git
- Node.js
- Python 3
- Salesforce CLI
- Salesforce Developer Org or Trailhead Playground

## Local Setup
```bash
git clone https://github.com/NamrataMargarett/smart-support-crm.git
cd smart-support-crm
```

## Salesforce Setup
- Authorize a Salesforce org using Salesforce CLI
- Deploy the repo metadata
- Assign permission sets
- Verify page layouts and queues

## Python Setup
```bash
cd ai-service
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app:app --reload
```

## Manual Validation
- Create account, contact, case
- Verify Flow automation
- Verify validation rules
- Test AI prediction endpoint
