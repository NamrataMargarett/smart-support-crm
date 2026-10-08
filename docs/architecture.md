# SmartSupport CRM Architecture

## High-Level Architecture
Salesforce stores customer, contact, and complaint data. Business logic is implemented using Flow and Apex. The system routes cases to support queues, escalates critical cases, and tracks SLA. A Python FastAPI service is used for complaint classification and priority prediction using a synthetic dataset and demo ML pipeline.

## Components
- Salesforce CRM
- Flow automation
- Apex service classes
- LWC dashboard and quick view
- Python AI service
- Synthetic complaint dataset

## Data Flow
Customer -> Contact -> Case -> Flow -> Priority/Assignment/Escalation -> SLA -> Reports and Dashboard

## AI Flow
Complaint Description -> FastAPI -> TF-IDF + Logistic Regression -> Category and Priority -> Salesforce update

## Design Principles
- Simple and beginner-friendly
- Flow-first automation strategy
- Apex only when required
- Synthetic educational dataset
