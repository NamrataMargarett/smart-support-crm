# SmartSupport AI Service

This is the Python component of the SmartSupport CRM project. It provides a lightweight complaint classification service used for demo and prototype support workflows.

## Purpose
- preprocess support complaint text
- classify complaint category
- predict priority level
- provide confidence score

## Setup

```bash
cd ai-service
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload
```

## API example

```bash
curl -X POST http://127.0.0.1:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"description":"My laptop battery is not charging and the screen is black"}'
```

## Expected response

```json
{
  "category": "Hardware",
  "priority": "Critical",
  "confidence": 0.91
}
```
