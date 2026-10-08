from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
import pandas as pd
import numpy as np

DATASET_PATH = "dataset/complaints.csv"


def load_data():
    """Load the synthetic complaint dataset."""
    df = pd.read_csv(DATASET_PATH)
    print(f"Loaded {len(df)} rows")
    return df


def build_pipeline(model_type="category"):
    """Build a TF-IDF + Logistic Regression pipeline for classification."""
    text_pipeline = Pipeline([
        ("tfidf", TfidfVectorizer(ngram_range=(1, 2), min_df=1, stop_words="english")),
        ("clf", LogisticRegression(max_iter=1000, multi_class="auto"))
    ])
    return text_pipeline


def evaluate_model(model, X_train, X_test, y_train, y_test):
    """Train and evaluate a classification model."""
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)

    metrics = {
        "accuracy": accuracy_score(y_test, y_pred),
        "precision": precision_score(y_test, y_pred, average="macro", zero_division=0),
        "recall": recall_score(y_test, y_pred, average="macro", zero_division=0),
        "f1": f1_score(y_test, y_pred, average="macro", zero_division=0),
        "confusion_matrix": confusion_matrix(y_test, y_pred)
    }

    return metrics


def main():
    df = load_data()
    X = df["description"]

    y_category = df["category"]
    y_priority = df["priority"]

    X_train_cat, X_test_cat, y_train_cat, y_test_cat = train_test_split(
        X, y_category, test_size=0.25, random_state=42, stratify=y_category
    )

    X_train_pri, X_test_pri, y_train_pri, y_test_pri = train_test_split(
        X, y_priority, test_size=0.25, random_state=42, stratify=y_priority
    )

    category_model = build_pipeline("category")
    priority_model = build_pipeline("priority")

    category_metrics = evaluate_model(category_model, X_train_cat, X_test_cat, y_train_cat, y_test_cat)
    priority_metrics = evaluate_model(priority_model, X_train_pri, X_test_pri, y_train_pri, y_test_pri)

    print("Category Metrics:")
    print(category_metrics)
    print("\nPriority Metrics:")
    print(priority_metrics)


if __name__ == "__main__":
    main()
