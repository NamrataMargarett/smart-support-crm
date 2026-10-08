# SmartSupport CRM - VS Code Setup (No Salesforce CLI Required)

This guide shows how to set up and run SmartSupport CRM entirely in VS Code without needing the Salesforce CLI.

## Part 1: Project overview

SmartSupport CRM is a professional Salesforce support management system with:
- Salesforce metadata and configuration (for deployment via Salesforce UI)
- Python AI service (runs in VS Code terminal)
- Professional dashboards and reporting
- Queue-based case routing
- SLA monitoring

## Part 2: What you need

### For Salesforce part
1. Salesforce Developer Edition org (free at developer.salesforce.com)
2. A web browser (no CLI needed)

### For AI service part
1. Python 3.10 or higher
2. VS Code with Python extension
3. Git (optional, for cloning)

## Part 3: Quick start

### Step 1: Clone the repository

```bash
git clone https://github.com/NamrataMargarett/smart-support-crm.git
cd smart-support-crm
```

Or download as ZIP and extract.

### Step 2: Set up Python AI service in VS Code

1. Open the repo folder in VS Code
2. Open terminal (Ctrl+` or View > Terminal)
3. Create a Python virtual environment:

```bash
cd ai-service
python -m venv .venv
```

4. Activate the virtual environment:

**Windows:**
```bash
.venv\Scripts\activate
```

**Mac/Linux:**
```bash
source .venv/bin/activate
```

5. Install dependencies:

```bash
pip install -r requirements.txt
```

6. Run the AI service:

```bash
uvicorn app:app --reload
```

You should see:
```
INFO:     Uvicorn running on http://127.0.0.1:8000
INFO:     Application startup complete
```

### Step 3: Test the AI service

Open a **new terminal** in VS Code (Ctrl+Shift+`) and run:

```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging"}'
```

**Expected response:**
```json
{
  "category": "Hardware",
  "priority": "Critical",
  "confidence": 0.91
}
```

If `curl` doesn't work on Windows, use this instead:

```bash
Invoke-WebRequest -Uri "http://127.0.0.1:8000/predict" -Method POST -ContentType "application/json" -Body '{"description":"My laptop battery is not charging"}'
```

## Part 4: Deploy Salesforce metadata (No CLI)

Your Salesforce metadata is ready in the `force-app` folder. Here's how to deploy without CLI:

### Option A: Deploy via Salesforce Org Setup (Recommended for first time)

1. Log into your Salesforce Developer Edition org
2. Go to **Setup** (click the gear icon)
3. Search for "Deploy"
4. Click **Deploy to Production** or **Deploy Changes**
5. Upload the metadata files from `force-app/main/default/`

### Option B: Deploy via Metadata API (VS Code alternative)

1. In VS Code, install the **Salesforce Extension Pack** (all extensions in `.vscode/extensions.json`)
2. Open Command Palette (Ctrl+Shift+P)
3. Type "SFDX: Authorize an Org"
4. Follow the browser login flow
5. Type "SFDX: Deploy Source to Org"
6. Select the `force-app` folder

### Option C: Manual setup (Copy-paste in Salesforce UI)

You can also copy individual files from the repo and paste them into Salesforce:

**For Apex classes:**
1. Go to Setup > Developer Console
2. Click File > New > Apex Class
3. Paste code from `force-app/main/default/classes/`
4. Save with correct name

**For LWC components:**
1. Go to Setup > Lightning Web Components
2. Click New
3. Copy files from `force-app/main/default/lwc/supportDashboard/`
4. Save

**For custom objects:**
1. Go to Setup > Object Manager
2. Click Create > Custom Object
3. Configure fields as per documentation
4. Save

## Part 5: Project structure for VS Code

```
smart-support-crm/
├── .vscode/                    # VS Code settings
│   ├── settings.json
│   ├── extensions.json
│   ├── tasks.json
│   └── launch.json
├── ai-service/                 # Python AI service
│   ├── app.py
│   ├── requirements.txt
│   ├── src/
│   ├── model/
│   ├── dataset/
│   └── .venv/                  # (created by setup)
├── force-app/                  # Salesforce metadata
│   └── main/default/
│       ├── classes/            # Apex code
│       ├── lwc/                # Lightning Web Components
│       ├── objects/            # Custom objects
│       ├── flows/              # Automation flows
│       └── dashboards/         # Dashboard configs
├── docs/                       # Documentation
│   ├── architecture.md
│   ├── dashboard.md
│   ├── setup.md
│   └── README.md
└── README.md
```

## Part 6: VS Code workflow

### Terminal 1: Run AI service
```bash
cd ai-service
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
uvicorn app:app --reload
```

### Terminal 2: Test and develop
```bash
# Test AI endpoint
curl http://127.0.0.1:8000/predict ...

# Or write Python tests
python -m pytest
```

### Salesforce side
- Use browser to log into org
- Deploy metadata manually or via VS Code extension
- Create test data
- Configure flows and validation rules

## Part 7: Key features to enable

Once metadata is deployed to Salesforce, configure:

### 1. Custom Objects
- Case (standard)
- Complaint__c (custom)
- Customer__c (custom)
- SLA_Config__c (custom)

### 2. Queues
- Technical Support
- Billing Support
- Customer Support
- Logistics Support

### 3. Permission Sets
- SmartSupport_Admin
- SmartSupport_Agent

### 4. Flows
- Case Auto-Assign Flow
- Case Escalation Flow
- Severity Alert Flow

### 5. Dashboard
- SmartSupport Executive Dashboard
- Support Operations Dashboard

## Part 8: Testing the integration

### Step 1: Run AI service in VS Code
```bash
cd ai-service
.venv\Scripts\activate  # Windows
uvicorn app:app --reload
```

### Step 2: Test prediction endpoint

In VS Code terminal:
```bash
curl -X POST http://127.0.0.1:8000/predict -H "Content-Type: application/json" -d '{"description":"Laptop screen is black"}'
```

### Step 3: Create a case in Salesforce
1. Log into Salesforce org
2. Click "Cases" tab
3. Create new case
4. Copy complaint text
5. Manually call prediction API or use Apex integration

### Step 4: View dashboard
1. Go to "SmartSupport Executive Dashboard"
2. Verify KPI cards show data
3. Check charts and metrics

## Part 9: Common issues and fixes

### "Python not found"
**Solution:** Install Python from python.org, ensure it's added to PATH

### "uvicorn: command not found"
**Solution:** Make sure `.venv` is activated and requirements.txt is installed

### "curl: command not found" (Windows)
**Solution:** Use `Invoke-WebRequest` PowerShell command instead

### "Port 8000 already in use"
**Solution:** Run on different port: `uvicorn app:app --reload --port 8001`

### "CORS error when calling from Salesforce"
**Solution:** Add CORS middleware to FastAPI:
```python
from fastapi.middleware.cors import CORSMiddleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

## Part 10: Next steps

1. ✅ Clone repo
2. ✅ Set up Python virtual environment
3. ✅ Run AI service in VS Code
4. ✅ Test prediction endpoint
5. ⏭️ Deploy Salesforce metadata to org
6. ⏭️ Create test data in Salesforce
7. ⏭️ Configure flows and permission sets
8. ⏭️ View dashboard and verify integration
9. ⏭️ Demo to team/professors

## Part 11: Demo script

### Scenario: A customer submits a complaint about a laptop

**Step 1: Show AI service in action**
```bash
# Terminal shows AI service running on http://127.0.0.1:8000
# Call prediction endpoint
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging and screen is black"}'
# Response shows: category="Hardware", priority="Critical", confidence=0.91
```

**Step 2: Show Salesforce UI**
1. Open Salesforce org
2. Navigate to Cases
3. Show case created from complaint
4. Show custom fields with AI prediction
5. Show case assigned to "Technical Support" queue
6. Show SLA status and escalation indicator

**Step 3: Show Dashboard**
1. Open SmartSupport Executive Dashboard
2. Show KPI cards (Open Cases, Critical Cases, SLA Breached, etc.)
3. Show case volume by category (Hardware prominent)
4. Show queue distribution
5. Show AI confidence summary

**Key talking points:**
- AI service classifies complaints in real-time
- Salesforce automates case routing based on category
- Dashboard provides leadership visibility
- System is scalable and professional

## Part 12: Deployment checklist

- [ ] Python environment set up
- [ ] AI service running and tested
- [ ] Salesforce org authorized
- [ ] Metadata deployed to org
- [ ] Custom objects created
- [ ] Queues configured
- [ ] Flows activated
- [ ] Permission sets assigned
- [ ] Test data created
- [ ] Dashboard published
- [ ] Demo script prepared
- [ ] Documentation reviewed

## Need help?

Refer to individual documentation files:
- `docs/architecture.md` - System design
- `docs/dashboard.md` - Dashboard layout
- `docs/setup.md` - Detailed setup
- `README.md` - Project overview

