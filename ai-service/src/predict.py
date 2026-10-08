import json
from pathlib import Path

import pandas as pd


DATASET_PATH = Path(__file__).resolve().parent.parent / "dataset" / "complaints.csv"
MODEL_DIR = Path(__file__).resolve().parent.parent / "model"


def load_data():
    """Load the synthetic complaint dataset."""
    df = pd.read_csv(DATASET_PATH)
    return df


def save_prediction(result):
    """Save a prediction result in JSON format."""
    out_path = MODEL_DIR / "last_prediction.json"
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2)
