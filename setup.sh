#!/bin/bash
# SmartSupport CRM - Quick setup script for VS Code (Mac/Linux)
# Run this to set up everything automatically

echo "=== SmartSupport CRM Setup ==="
echo ""

# Step 1: Check Python
echo "Step 1: Checking Python..."
if ! command -v python3 &> /dev/null; then
    echo "Python not found. Install from python.org"
    exit 1
fi
echo "✓ Python found: $(python3 --version)"
echo ""

# Step 2: Create virtual environment
echo "Step 2: Creating Python virtual environment..."
cd ai-service
python3 -m venv .venv
echo "✓ Virtual environment created"
echo ""

# Step 3: Activate and install
echo "Step 3: Installing dependencies..."
source .venv/bin/activate
pip install -r requirements.txt
echo "✓ Dependencies installed"
echo ""

# Step 4: Test FastAPI
echo "Step 4: Starting AI service (will run for 5 seconds for testing)..."
echo "Press Ctrl+C to stop"
echo ""
timeout 5 uvicorn app:app --reload || true
echo ""

echo "=== Setup Complete ==="
echo ""
echo "To run AI service anytime:"
echo "  cd ai-service"
echo "  source .venv/bin/activate"
echo "  uvicorn app:app --reload"
echo ""
echo "To test in another terminal:"
echo "  curl -X POST http://127.0.0.1:8000/predict \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -d '{\"description\":\"My laptop battery is not charging\"}'"
echo ""
