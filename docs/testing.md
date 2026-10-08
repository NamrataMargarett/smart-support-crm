# Testing Guide

## Salesforce Testing
- Premium + Hardware -> High priority
- Enterprise + Hardware -> Critical priority
- Case category Billing -> High priority
- Shipping -> Logistics support assignment
- Critical case -> Escalation Required and status Escalated
- Closed case without resolution -> validation error
- Closed case with resolution -> save successfully

## AI Testing
```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop is overheating and shutting down"}'
```

## LWC Testing
- Verify dashboard displays metrics
- Verify quick view renders case details
- Test responsiveness on smaller screens
