# SmartSupport CRM

SmartSupport CRM is a professional Salesforce-based support and case management solution designed for customer complaint handling, queue assignment, SLA tracking, and AI-assisted categorization.

## Project overview

This project combines:
- Salesforce Lightning Experience for case operations and dashboards
- Flow and Apex for support automation and escalation logic
- LWC dashboards for operations visibility
- Python FastAPI service for complaint prediction and category scoring
- Professional documentation for enterprise-style project delivery

## Business use case

Organizations receive support requests across categories such as hardware, software, billing, account access, refunds, and shipping. SmartSupport CRM helps teams manage these requests in one place, route cases to the right queue, monitor SLA breaches, and identify trends through dashboards.

## Key features
- Customer and contact management
- Complaint and case intake
- Priority and severity automation
- Queue assignment by support area
- Critical issue escalation and SLA tracking
- AI-powered complaint categorization
- Executive dashboard with KPI monitoring
- Professional demo-ready project structure for VS Code

## Tech stack
- Salesforce DX
- Apex
- Flow
- Lightning Web Components
- Python
- FastAPI
- Pandas, NumPy, scikit-learn

## Repository structure

```text
smart-support-crm/
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   ├── tasks.json
│   └── launch.json
├── ai-service/
│   ├── app.py
│   ├── README.md
│   ├── requirements.txt
│   ├── dataset/
│   ├── model/
│   └── src/
├── docs/
│   ├── architecture.md
│   ├── dashboard.md
│   ├── setup.md
│   └── README.md
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/
│           ├── dashboards/
│           ├── flows/
│           ├── lwc/
│           ├── objects/
│           ├── permissionsets/
│           ├── queues/
│           ├── reports/
│           └── README.md
├── README.md
├── sfdx-project.json
└── .gitignore
```

## VS Code setup

Open this folder in VS Code and install recommended extensions:
- Salesforce Extension Pack
- Python
- Pylance
- ESLint
- GitHub Copilot

From the VS Code terminal, run:

```bash
# Salesforce project validation
sfdx force:project:upgrade -f

# Deploy metadata to your org
sfdx force:source:deploy -p force-app
```

For the AI service:

```bash
cd ai-service
python -m venv .venv
source .venv/bin/activate   # Mac/Linux
# or .venv\Scripts\activate  # Windows
pip install -r requirements.txt
uvicorn app:app --reload
```

Then test the API:

```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging and the screen is black"}'
```

## Professional dashboard design

The dashboard should include:
- Total Open Cases
- SLA Breach Rate
- High Priority Cases
- Cases Resolved Today
- Case Volume by Category
- Case Volume by Queue
- Cases by Channel
- AI prediction confidence summary

## Best design decisions

1. Use standard Salesforce objects: Account, Contact, Case
2. Add custom domain objects for complaint and SLA metadata
3. Keep AI prediction separate from core CRM logic
4. Standardize naming conventions and metadata organization
5. Use queues and permission sets to simulate real support operations
6. Separate dashboards for operations and executive reporting

## Deployment approach

1. Author metadata in VS Code
2. Validate with Salesforce CLI
3. Deploy to a Developer Edition org
4. Activate flows and permission sets
5. Connect AI service endpoint
6. Publish dashboard and test live usage

## Documentation

- Architecture: `docs/architecture.md`
- Setup guide: `docs/setup.md`
- Dashboard design: `docs/dashboard.md`

## Current status
This repo is structured as a professional Salesforce + AI support management project ready for team development and demo use in VS Code.

## License
This project is intended for educational and demo use.
