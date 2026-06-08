---
title: InterviewAI Backend
emoji: 🎯
colorFrom: purple
colorTo: blue
sdk: docker
app_port: 7860
pinned: false
---

# InterviewAI – AI-Powered Mock Interview Platform

InterviewAI is a full-stack, AI-driven mock interview application designed to help users practice for job interviews. The platform evaluates user responses in real-time across multiple NLP-based metrics, providing instant, data-driven feedback and scores to help candidates improve their communication and technical skills.

---

## 🔗 Live Demo

| | Link |
|---|---|
| 🌐 **Frontend (Live App)** | [interview-ai-eight-rho.vercel.app](https://interview-ai-eight-rho.vercel.app) |
| ⚙️ **Backend API** | [nitish2812-interviewai-backend.hf.space](https://nitish2812-interviewai-backend.hf.space) |
| 🤗 **HF Space** | [huggingface.co/spaces/Nitish2812/interviewai-backend](https://huggingface.co/spaces/Nitish2812/interviewai-backend) |

---

## 🚀 Complete Project Workflow

1. **Authentication:** Users sign up or log in securely using Supabase Authentication.
2. **Select a Track:** Users are presented with a personalized dashboard where they can choose from 5 distinct interview tracks (e.g., Software Engineering Basics, HR & Culture Fit, Data Science).
3. **Live Interview Session:**
   - The app fetches curated questions from the FastAPI backend based on the selected track.
   - Users can answer questions by **typing text** or using **voice input** (which is transcribed to text via Google Speech Recognition).
4. **AI Evaluation (NLP Pipeline):** Once submitted, the backend analyzes the answers across 4 key dimensions:
   - **Semantic Relevance:** Uses `SBERT (all-MiniLM-L6-v2)` to compute cosine similarity between the question and answer embeddings.
   - **Sentiment & Confidence:** Uses HuggingFace's `DistilBERT (finetuned-sst-2)` to ensure the candidate's tone is positive and confident.
   - **Keyword Match:** Uses `NLTK` (lemmatization + tokenization) to check if essential technical jargon was used.
   - **Clarity & Delivery:** Evaluates sentence length, filler words ("um", "uh"), and speaking pace in WPM (if audio was used).
5. **Results Dashboard:** Users receive an aggregated overall score on a circular gauge, along with individual metric breakdowns and targeted, actionable feedback.

---

## 💻 Tech Stack

### Frontend
![React](https://img.shields.io/badge/React_18-20232A?style=flat&logo=react&logoColor=61DAFB)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat&logo=typescript&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-B73BFE?style=flat&logo=vite&logoColor=FFD62E)
![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=flat&logo=tailwind-css&logoColor=white)
![Vercel](https://img.shields.io/badge/Vercel-000000?style=flat&logo=vercel&logoColor=white)

* **Framework:** React 18 with TypeScript & Vite
* **Styling:** Tailwind CSS (Glassmorphism design)
* **Routing:** React Router v6
* **State & Data Fetching:** React Context API, Axios
* **Deployment:** Vercel

### Backend & AI Engine
![Python](https://img.shields.io/badge/Python_3.10-3776AB?style=flat&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=flat&logo=docker&logoColor=white)
![HuggingFace](https://img.shields.io/badge/HuggingFace-FFD21E?style=flat&logo=huggingface&logoColor=black)

* **Framework:** FastAPI (Python 3.10+)
* **Server:** Uvicorn (ASGI)
* **Semantic Similarity:** `sentence-transformers` — `all-MiniLM-L6-v2` (SBERT)
* **Sentiment Analysis:** `transformers` — `distilbert-base-uncased-finetuned-sst-2-english`
* **NLP Processing:** NLTK (lemmatization, tokenization, stopword removal)
* **Audio Processing:** `SpeechRecognition` (Google API), `pydub`, `ffmpeg`
* **Containerization:** Docker
* **Deployment:** Hugging Face Spaces

### Database & Auth
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=flat&logo=supabase&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)

* **Infrastructure:** Supabase
* **Database:** PostgreSQL (with Row-Level Security)
* **Auth:** Supabase Authentication (email/password)

---

## 🏗️ Deployment Architecture

```
User Browser
     │
     ▼
┌─────────────────────┐        ┌──────────────────────────────────┐
│  Vercel (Frontend)  │──API──▶│  Hugging Face Spaces (Backend)   │
│  React + TypeScript │        │  FastAPI + Docker Container       │
│  interview-ai-      │        │  SBERT + DistilBERT + NLTK        │
│  eight-rho.vercel   │        │  nitish2812-interviewai-          │
│  .app               │        │  backend.hf.space                 │
└─────────────────────┘        └──────────────────────────────────┘
           │                                    │
           ▼                                    ▼
┌─────────────────────┐              Pre-loaded ML Models
│  Supabase           │              (baked into Docker image)
│  Auth + PostgreSQL  │
└─────────────────────┘
```

---

## ⚙️ Local Setup & Prerequisites

1. **Python 3.10+** & **Node.js 18+** must be installed.
2. **SBERT Model Extraction:**
   **⚠️ CRITICAL:** Unzip `sbert_model.zip` into a folder named `sbert_model/` in the project root before running the backend.
3. **Environment Variables:**
   Create `frontend/.env` with:
   ```env
   VITE_SUPABASE_URL=your_supabase_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   VITE_API_URL=http://localhost:8000
   ```

---

## 🏃‍♂️ How to Run Locally

### 1. Start the Python Backend
```bash
# From project root
pip install -r backend/requirements.txt
uvicorn backend.app:app --reload --port 8000
```
*Backend API runs at **http://localhost:8000***

### 2. Start the React Frontend
```bash
cd frontend
npm install
npm run dev
```
*Frontend runs at **http://localhost:5173***

---

## 🔗 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET`  | `/` | Health check |
| `GET`  | `/questions` | Fetch questions (`?category=Technical&count=7`) |
| `POST` | `/analyze` | Analyze a single Q&A pair |
| `POST` | `/analyze-session` | Batch analyze a full interview session |

---

## 📁 Project Structure

```
nlp(project)/
├── backend/
│   ├── app.py              # FastAPI server & API endpoints
│   └── requirements.txt    # Python dependencies
├── analyzer.py             # Core NLP analysis engine
├── question_bank.json      # 750+ curated interview questions
├── sbert_model/            # Local SBERT model weights
├── weights.pkl             # Scoring weights (text vs audio)
├── Dockerfile              # Docker config for HF Spaces deployment
├── frontend/
│   ├── src/
│   │   └── services/api.ts # Axios API client
│   └── .env                # Environment variables
└── README.md
```

---

## 👨‍💻 Author

**Repalle Sai Nitish**
[![GitHub](https://img.shields.io/badge/GitHub-nitish--2812-181717?style=flat&logo=github)](https://github.com/nitish-2812)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-nitish--2812-0077B5?style=flat&logo=linkedin)](https://linkedin.com/in/nitish-2812)
