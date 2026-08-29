# Artisan AI - Smart Cataloging Module

AI-Driven Market Linkage and Smart Cataloging Mobile Application for Marginalized Artisans MVP backend.

## Project Structure

```
artisan-ai/
│
├── app/
│   ├── main.py          # FastAPI app & endpoint handlers
│   ├── vision.py        # Vision AI service abstraction layer
│   ├── catalog.py       # Catalog generation service layer
│   ├── schemas.py       # Pydantic data schemas
│   └── config.py        # Environment variables & configuration
│
├── prompts/
│   ├── product_analysis.txt   # Prompt template for product analysis
│   └── catalog_generation.txt # Prompt template for catalog generation
│
├── data/
│   └── images/          # Sample images storage
│
├── tests/               # Unit and integration test suite
│
├── .env                 # Environment secrets (ignored by git)
├── .env.example         # Example environment template
├── .gitignore
├── requirements.txt     # Python project dependencies
└── README.md
```

## Setup Instructions

### 1. Create and Activate Virtual Environment

**Windows:**
```powershell
python -m venv venv
.\venv\Scripts\activate
```

**Linux/macOS:**
```bash
python3 -m venv venv
source venv/bin/activate
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Configure Secrets

Copy `.env.example` to `.env` and fill in your API key:
```bash
cp .env.example .env
```

### 4. Run Development Server

```bash
uvicorn app.main:app --reload --port 8000
```

Access API documentation at: `http://localhost:8000/docs`
