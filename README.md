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

## 🚀 Complete Project Workflow

1. **Authentication:** Users sign up or log in securely using Supabase Authentication.
2. **Select a Track:** Users are presented with a personalized dashboard where they can choose from 5 distinct interview tracks (e.g., Software Engineering Basics, HR & Culture Fit, Data Science).
3. **Live Interview Session:** 
   - The app fetches curated questions from the FastAPI backend based on the selected track.
   - Users can answer questions by **typing text** or using **voice input** (which is transcribed to text).
4. **AI Evaluation (NLP Pipeline):** Once submitted, the backend analyzes the answers across 4 key dimensions:
   - **Semantic Relevance:** Uses `SBERT (Sentence-BERT)` to calculate how closely the meaning of the answer aligns with the question.
   - **Sentiment & Confidence:** Uses HuggingFace's `DistilBERT` to ensure the candidate's tone is positive and confident.
   - **Keyword Match:** Uses `NLTK` (lemmatization and tokenization) to check if essential technical jargon was used.
   - **Clarity & Delivery:** Evaluates sentence length, filler words ("um", "uh"), and speaking pace (if audio was used).
5. **Results Dashboard:** Users receive an aggregated overall score on a circular gauge, along with individual metric breakdowns and targeted feedback on their strengths and areas to improve.

---

## 💻 Tech Stack

### Frontend
* **Framework:** React 18 with TypeScript & Vite
* **Styling:** Tailwind CSS (Glassmorphism design)
* **Routing:** React Router v6
* **State & Data Fetching:** React Context API, Axios

### Backend & AI Engine
* **Framework:** FastAPI (Python 3.10+)
* **Server:** Uvicorn (ASGI)
* **Transformers:** `sentence-transformers` (all-MiniLM-L6-v2), `transformers` (HuggingFace pipeline)
* **NLP Processing:** NLTK (Natural Language Toolkit)
* **Audio Processing:** `SpeechRecognition` (Google API), `pydub`

### Database & Auth
* **Infrastructure:** Supabase
* **Database:** PostgreSQL (with Row-Level Security)

---

## ⚙️ Essential Setup & Prerequisites

1. **Python 3.10+** & **Node.js 18+** must be installed.
2. **SBERT Model Extraction:**  
   **⚠️ CRITICAL:** You must unzip the provided `sbert_model.zip` file into a folder named `sbert_model/` in the root of the project before running the backend. The NLP engine relies on this local model to run without downloading it from the internet every time.
3. **Environment Variables:**
   Ensure the `frontend/.env` file contains your Supabase credentials:
   ```env
   VITE_SUPABASE_URL=your_supabase_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   VITE_API_URL=http://localhost:8000
   ```

---

## 🏃‍♂️ How to Run Locally

### 1. Start the Python Backend
Open a terminal and navigate to the project root:
```bash
cd backend
pip install -r requirements.txt
uvicorn app:app --reload --port 8000
```
*The backend API will run at **http://localhost:8000***

### 2. Start the React Frontend
Open a **new terminal** and navigate to the project root:
```bash
cd frontend
npm install
npm run dev
```
*The frontend will run at **http://localhost:5173***

---

## 🔗 API Endpoints Overview

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET  | `/`                | Health check |
| GET  | `/questions`       | Get random questions (`?category=Technical&count=7`) |
| POST | `/analyze`         | Analyze a single Q&A pair |
| POST | `/analyze-session` | Batch analyze a full interview session |
