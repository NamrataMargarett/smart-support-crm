# SmartSupport CRM - Getting Started Without Salesforce CLI

This repo works without Salesforce CLI. Here are your options:

## Option 1: Python AI Service Only (Fastest)

Run just the AI/ML part in VS Code:

```bash
cd ai-service
python -m venv .venv

# Windows:
.venv\Scripts\activate

# Mac/Linux:
source .venv/bin/activate

pip install -r requirements.txt
uvicorn app:app --reload
```

Test:
```bash
curl -X POST http://127.0.0.1:8000/predict -H "Content-Type: application/json" -d '{"description":"laptop not charging"}'
```

**Time to running: 3 minutes**

---

## Option 2: Auto Setup Script (Recommended)

**Mac/Linux:**
```bash
bash setup.sh
```

**Windows:**
```bash
setup.bat
```

These scripts:
- Create Python virtual environment
- Install dependencies
- Test FastAPI server
- Show commands to run later

**Time to running: 5 minutes**

---

## Option 3: Salesforce Extension in VS Code (Recommended if you have Salesforce org)

See `VSCODE_EXTENSION_SETUP.md` for step-by-step:

1. Install Salesforce Extension Pack from VS Code marketplace
2. Authorize your Salesforce org (browser login, no CLI)
3. Deploy metadata with one command
4. Run AI service
5. Test integration

**Time to running: 10-15 minutes**

---

## Option 4: Complete Manual Setup (Full control)

See `VSCODE_SETUP_NO_CLI.md` for comprehensive guide:

1. Manual Python environment setup
2. Step-by-step Salesforce deployment
3. Complete workflow documentation
4. Troubleshooting guide
5. Demo script

**Time to running: 20-30 minutes**

---

## Choose your path:

| Goal | Option | Time |
|------|--------|------|
| Just test AI service | Option 1 | 3 min |
| Quick setup | Option 2 | 5 min |
| Include Salesforce | Option 3 | 15 min |
| Detailed walkthrough | Option 4 | 30 min |

---

## Quick test right now

If you have Python installed:

```bash
git clone https://github.com/NamrataMargarett/smart-support-crm.git
cd smart-support-crm/ai-service
python -m venv .venv
.venv\Scripts\activate  # or: source .venv/bin/activate on Mac/Linux
pip install -r requirements.txt
uvicorn app:app --reload
```

Then in another terminal:
```bash
curl -X POST http://127.0.0.1:8000/predict -H "Content-Type: application/json" -d '{"description":"My laptop battery is not charging"}'
```

You should see:
```json
{"category":"Hardware","priority":"Critical","confidence":0.91}
```

✅ **AI service is working!**

---

## Next: Set up Salesforce part

Once AI service is running:

### Method A: Use Salesforce Extension (Easier)
- Install "Salesforce Extension Pack" from VS Code extensions
- Command Palette > SFDX: Authorize an Org
- Login in browser
- Command Palette > SFDX: Deploy Source to Org
- Done!

### Method B: Manual in Salesforce UI
- Log into Salesforce Developer Edition
- Setup > Developer Console
- Copy-paste Apex classes from `force-app/main/default/classes/`
- Setup > Lightning Web Components
- Copy-paste LWC files from `force-app/main/default/lwc/`
- Create custom objects and dashboards

---

## Questions?

Refer to:
- `VSCODE_EXTENSION_SETUP.md` - Easiest way with extension
- `VSCODE_SETUP_NO_CLI.md` - Complete manual guide
- `docs/setup.md` - Salesforce-focused setup

