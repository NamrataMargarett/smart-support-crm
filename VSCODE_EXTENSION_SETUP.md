# SmartSupport CRM - Advanced VS Code Setup with Salesforce Extension

This guide uses Salesforce VS Code extension (no CLI install needed, but requires browser auth).

## What you need

1. **VS Code** installed
2. **Python 3.10+**
3. **Salesforce Extension Pack** (from VS Code marketplace)
4. **Salesforce Developer Edition org** (free)
5. **Internet browser** (for Salesforce login)

## Part 1: Install Salesforce Extension in VS Code

### Step 1: Open VS Code

### Step 2: Go to Extensions marketplace
Click the Extensions icon on the left sidebar (or Ctrl+Shift+X)

### Step 3: Search and install
Search for **"Salesforce Extension Pack"** and click Install

This installs:
- Salesforce DX CLI wrapper
- Salesforce Language Server
- Lightning Web Components extension
- Apex Language Server

### Step 4: Verify installation
Open Command Palette (Ctrl+Shift+P) and type:
```
SFDX: Get Org Info
```

If it shows, the extension is ready.

## Part 2: Authorize Salesforce org (No CLI download needed)

### Step 1: Open Command Palette
Ctrl+Shift+P

### Step 2: Type and select
```
SFDX: Authorize an Org
```

### Step 3: Choose login type
Select **Production** (or **Sandbox** if you prefer)

### Step 4: Browser login
A browser window opens. Log in with your Salesforce Developer Edition credentials.

### Step 5: Authorize VS Code
Click "Allow" to authorize VS Code to access your org.

### Step 6: Confirm in VS Code
You'll see a notification:
```
Successfully authenticated org with username: your-email@example.com
```

## Part 3: Deploy metadata without CLI

### Method 1: Deploy source files

1. Open Command Palette (Ctrl+Shift+P)
2. Type:
```
SFDX: Deploy Source to Org
```
3. Select `force-app` folder
4. Wait for deployment confirmation

### Method 2: Deploy using VS Code UI

1. Right-click on `force-app` folder
2. Select "SFDX: Deploy Source to Org"
3. Confirm deployment

### Method 3: Manual deployment (file by file)

If automated deployment fails:

1. Open your Salesforce org in browser
2. Go to Setup > Developer Console
3. For each file in `force-app/main/default/classes/`:
   - File > New > Apex Class
   - Copy-paste the code
   - Save with correct filename
4. For LWC components:
   - Setup > Lightning Web Components
   - Click New
   - Copy files from `force-app/main/default/lwc/`

## Part 4: Set up Python in VS Code

### Step 1: Select Python interpreter

1. Open Command Palette (Ctrl+Shift+P)
2. Type:
```
Python: Select Interpreter
```
3. Click "Create new virtual environment"
4. Choose Python version (3.10 or higher)
5. Select `ai-service` folder

### Step 2: VS Code creates .venv automatically

You'll see:
```
Creating new virtual environment...
.venv folder created
```

### Step 3: Install requirements

1. Open terminal in VS Code (Ctrl+`)
2. Navigate to ai-service:
```bash
cd ai-service
```

3. Install packages:
```bash
pip install -r requirements.txt
```

## Part 5: Run everything in VS Code

### Terminal 1: Run AI service

1. Open terminal (Ctrl+Shift+`)
2. Make sure you're in ai-service folder
3. Run:
```bash
uvicorn app:app --reload
```

You should see:
```
INFO:     Uvicorn running on http://127.0.0.1:8000
```

### Terminal 2: Test AI service

1. Open new terminal (Ctrl+Shift+`)
2. Test endpoint:

**Windows PowerShell:**
```powershell
$body = @{description="My laptop battery is not charging"} | ConvertTo-Json
Invoke-WebRequest -Uri "http://127.0.0.1:8000/predict" -Method POST -ContentType "application/json" -Body $body
```

**Mac/Linux/Git Bash:**
```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging"}'
```

**Expected output:**
```json
{"category":"Hardware","priority":"Critical","confidence":0.91}
```

## Part 6: Use VS Code tasks (automation)

Your `.vscode/tasks.json` already has automation configured.

### Run via Command Palette

1. Press Ctrl+Shift+P
2. Type:
```
Tasks: Run Task
```
3. Select "Run AI Service" or "Deploy Salesforce Metadata"

## Part 7: Debug Python in VS Code

### Set breakpoint
1. Click left margin of `ai-service/app.py` at line you want to debug
2. Red dot appears

### Start debugging
1. Press F5 (or click Debug icon on left)
2. Select "Python: AI Service" from dropdown
3. Execution stops at breakpoint

### Inspect variables
Hover over variables to see their values during debug.

## Part 8: View Salesforce org from VS Code

### Explore org metadata

1. Open Command Palette (Ctrl+Shift+P)
2. Type:
```
SFDX: Retrieve Source from Org
```
3. Select items to retrieve
4. Files appear in VS Code workspace

### View org info

1. Command Palette
2. Type:
```
SFDX: Get Org Info
```
3. Shows org ID, instance, and admin email

## Part 9: Complete workflow in VS Code

### Day 1: Initial setup
```bash
# Terminal 1: Install dependencies
cd ai-service
pip install -r requirements.txt

# Terminal 2: Authorize org
# Command Palette > SFDX: Authorize an Org
# (browser login flow)

# Terminal 3: Deploy metadata
# Command Palette > SFDX: Deploy Source to Org
```

### Day 2: Run and test
```bash
# Terminal 1: Run AI service
cd ai-service
uvicorn app:app --reload

# Terminal 2: Test API
curl -X POST http://127.0.0.1:8000/predict ...

# Browser: Log into Salesforce
# Create test case
# View dashboard
```

### Day 3: Debug and optimize
```bash
# Terminal: Debug Python code
F5 (start debugger)

# Fix issues, test again
# Deploy updates to Salesforce
```

## Part 10: Troubleshooting

### "Salesforce Extension not found"
**Fix:** Go to Extensions, search "Salesforce Extension Pack", click Install

### "Org not authorized"
**Fix:** 
1. Command Palette > SFDX: Authorize an Org
2. Log in with Developer Edition account
3. Allow VS Code permissions

### "Metadata deployment failed"
**Fix:**
1. Check metadata format (XML files must be valid)
2. Try deploying single file first
3. Check Salesforce org limits not exceeded

### "Python module not found"
**Fix:**
1. Make sure virtual environment is activated
2. Run: `pip install -r requirements.txt`
3. Select correct Python interpreter in VS Code

### "Port 8000 in use"
**Fix:** Use different port:
```bash
uvicorn app:app --reload --port 8001
```

## Part 11: Key VS Code shortcuts

| Action | Shortcut |
|--------|----------|
| Open Command Palette | Ctrl+Shift+P |
| Open Terminal | Ctrl+` |
| New Terminal | Ctrl+Shift+` |
| Extensions | Ctrl+Shift+X |
| Debug | F5 |
| Stop Debug | Shift+F5 |
| Save file | Ctrl+S |
| Format code | Shift+Alt+F |

## Part 12: Demo walkthrough

### Live demo in VS Code

**Step 1: Show AI service**
```bash
# Terminal visible
uvicorn app:app running on http://127.0.0.1:8000
```

**Step 2: Test prediction**
```bash
# Terminal 2
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop is not charging and overheating"}'

# Output shows:
# {"category":"Hardware","priority":"Critical","confidence":0.91}
```

**Step 3: Show code in VS Code**
- Open `ai-service/app.py`
- Show prediction logic
- Show model loading

**Step 4: Switch to browser**
- Open Salesforce org
- Show case created
- Show case assigned to "Technical Support" queue
- Show AI prediction stored in custom field

**Step 5: Show dashboard**
- Open SmartSupport Dashboard
- Show KPI cards
- Show case volume charts
- Show queue distribution

**Talking points:**
- "Here's the AI service running in VS Code"
- "It classifies support tickets in real-time"
- "Salesforce automatically routes the case"
- "Dashboard shows operations health"

## Next steps

1. Install Salesforce Extension Pack
2. Authorize your Developer Edition org
3. Deploy metadata to org
4. Set up Python virtual environment
5. Run AI service in VS Code
6. Test prediction endpoint
7. Create test cases in Salesforce
8. View dashboard
9. Prepare demo script

