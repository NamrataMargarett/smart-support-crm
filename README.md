# SmartSupport CRM

## Project Title
Smart Customer Support & Complaint Management System Using Salesforce

## Overview
SmartSupport CRM is a Salesforce-based support and complaint management system designed for a final-year B.Tech AI/ML project. The project demonstrates how companies can manage customer complaints, assign support teams, automate priority rules, handle escalation, track SLA, and use AI-based classification for complaint handling.

## Problem Statement
Organizations often receive large numbers of customer complaints across categories such as hardware, software, billing, account, refund, and shipping. Without a proper workflow, these complaints may remain unresolved, create SLA breaches, and reduce customer satisfaction.

## Objectives
- Store customer and contact information
- Manage support cases efficiently
- Automate case priority rules
- Route cases to correct support queues
- Escalate critical complaints
- Track resolution and SLA compliance
- Use AI-based classification for category and priority prediction
- Present reports and dashboards for management visibility

## Features
- Account and Contact management
- Case tracking using Salesforce Case object
- Priority automation using Flow
- Assignment routing using queues
- Critical escalation logic
- Validation rules for closure and critical cases
- SLA status tracking
- LWC dashboard and quick view
- Python AI service for complaint prediction
- Synthetic demo dataset for ML model training

## Architecture
The solution combines Salesforce and Python:
- Salesforce stores customers, contacts, and cases
- Flow automates business logic
- Apex is used only where required
- LWC provides dashboard and quick view experience
- FastAPI service handles complaint prediction using a demo ML model

## Technology Stack
- Salesforce Lightning Experience
- Salesforce CRM Objects
- Flow
- Apex
- LWC
- Python
- FastAPI
- Pandas
- NumPy
- scikit-learn
- TF-IDF
- Logistic Regression

## Salesforce Setup
1. Create or open a Salesforce Developer Edition org
2. Deploy the metadata from the repo
3. Verify custom fields and queues
4. Assign permission sets to users
5. Configure page layouts and Lightning pages
6. Activate the required flows

## AI Setup
1. Create a Python virtual environment
2. Install dependencies from `ai-service/requirements.txt`
3. Run the FastAPI app locally
4. Test the `/predict` endpoint using sample complaint text

## Running Instructions
### Salesforce
```bash
sfdx project deploy start
```

### Python AI service
```bash
cd ai-service
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app:app --reload
```

### Prediction request
```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop is not charging"}'
```

## Testing
The project covers:
- Premium + Hardware priority rules
- Enterprise + Hardware escalation logic
- Billing priority rules
- Support assignment routing
- Case closure validation
- AI prediction response structure
- LWC rendering


## Limitations
- AI model is demonstration-level only
- Synthetic dataset is used for training demonstration
- Real org setup is required for deployment and testing
- Salesforce authentication and org access must be configured manually

## Future Enhancements
- Agentforce
- Knowledge Base
- Sentiment Analysis
- Multilingual Complaint Classification
- Email Integration
- WhatsApp Integration
- Advanced ML Models
- Customer Self-Service Portal

## Conclusion
SmartSupport CRM demonstrates how Salesforce can be used to create a modern complaint and support management system with AI-powered classification. It is suitable for a B.Tech final-year project, college viva, GitHub portfolio, and career interviews.
