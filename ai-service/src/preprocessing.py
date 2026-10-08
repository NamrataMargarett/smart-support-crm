import re
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer


def clean_text(text):
    """Simple text cleaning for complaint descriptions."""
    if pd.isna(text):
        return ""
    text = text.lower()
    text = re.sub(r"[^a-z0-9\s]", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def preprocess_dataset(df):
    """Apply preprocessing and return cleaned text."""
    df = df.copy()
    df["description"] = df["description"].apply(clean_text)
    return df
