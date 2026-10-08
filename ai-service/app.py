from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
from pathlib import Path
import json

from src.preprocessing import preprocess_dataset
from src.predict import save_prediction

app = FastAPI(title="SmartSupport AI Service")


class ComplaintRequest(BaseModel):
    description: str


@app.get("/health")
def health_check():
    return {"status": "ok", "service": "smartsupport-ai"}


@app.post("/predict")
def predict_complaint(request: ComplaintRequest):
    description = request.description
    df = pd.read_csv(Path(__file__).resolve().parent / "dataset" / "complaints.csv")
    cleaned = preprocess_dataset(df)

    # Demo-only logic: classify based on keyword matching.
    text = description.lower()

    if any(word in text for word in ["laptop", "battery", "screen", "charger", "keyboard", "monitor", "hardware", "power", "camera", "trackpad"]):
        category = "Hardware"
    elif any(word in text for word in ["password", "account", "login", "email", "verification", "profile", "security"]):
        category = "Account"
    elif any(word in text for word in ["bill", "charged", "invoice", "fee", "payment", "billing"]):
        category = "Billing"
    elif any(word in text for word in ["refund", "return", "money", "wallet"]):
        category = "Refund"
    elif any(word in text for word in ["delivery", "shipment", "order", "package", "shipping", "courier", "parcel"]):
        category = "Shipping"
    else:
        category = "Software"

    if any(word in text for word in ["overheat", "not charging", "black screen", "battery", "crack", "not powering", "swelling", "clicking"]):
        priority = "Critical"
    elif any(word in text for word in ["charged twice", "refund", "duplicate", "lost", "damaged", "billing"]):
        priority = "High"
    elif any(word in text for word in ["forgot password", "login", "email", "slow", "app crashes"]):
        priority = "Medium"
    else:
        priority = "Medium"

    confidence = 0.91 if category == "Hardware" and "not charging" in text else 0.88

    result = {
        "category": category,
        "priority": priority,
        "confidence": round(confidence, 2)
    }

    save_prediction(result)
    return result
