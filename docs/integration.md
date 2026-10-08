# SmartSupport AI Integration Notes

This file documents the Salesforce-to-Python integration pattern for the demo project.

- The Python FastAPI service runs locally at http://127.0.0.1:8000
- Salesforce Apex uses an HTTP callout to POST complaint descriptions
- The callout target is protected by a Named Credential and External Credential pattern
- This is a demonstration setup and must be configured in a real org with valid permissions

Important:
- Do not hard-code credentials in Apex or GitHub
- Use Named Credentials or environment-based configuration in a real org
- This setup requires a real Salesforce org and authenticated API endpoint before production use
