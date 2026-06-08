<div align="center">

# 🎯 InterviewAI

### AI-Powered Mock Interview Platform

*Practice interviews with real-time NLP feedback on relevance, sentiment, keywords, and delivery*

[![Live Demo](https://img.shields.io/badge/Live%20Demo-interview--ai--eight--rho.vercel.app-6366f1?style=for-the-badge&logo=vercel&logoColor=white)](https://interview-ai-eight-rho.vercel.app)
[![Backend API](https://img.shields.io/badge/Backend%20API-HuggingFace%20Spaces-FFD21E?style=for-the-badge&logo=huggingface&logoColor=black)](https://huggingface.co/spaces/Nitish2812/interviewai-backend)
[![GitHub](https://img.shields.io/badge/GitHub-nitish--2812-181717?style=for-the-badge&logo=github)](https://github.com/nitish-2812/InterviewAI)

![React](https://img.shields.io/badge/React_18-20232A?style=flat-square&logo=react&logoColor=61DAFB)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat-square&logo=typescript&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python_3.10-3776AB?style=flat-square&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=flat-square&logo=docker&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=flat-square&logo=supabase&logoColor=white)

</div>

---

## Overview

InterviewAI is a full-stack application that simulates real job interviews and evaluates your answers using a custom NLP pipeline — no GPT, no paid APIs. All models run locally inside a Docker container on Hugging Face Spaces.

Users can answer questions by **typing** or using **voice input**, and receive instant scoring across 4 dimensions with targeted feedback to improve.

---

## Features

- 🎤 **Voice + Text Input** — Answer by speaking or typing; audio is transcribed via Google Speech Recognition
- 🧠 **4-Metric NLP Scoring** — Semantic relevance, sentiment confidence, keyword match, and clarity
- 📊 **Real-Time Feedback** — Circular score gauge + per-metric breakdown + actionable suggestions
- 🗂️ **5 Interview Tracks** — Software Engineering, Data Science, HR, System Design, and more
- 🔐 **Auth + History** — Supabase authentication with PostgreSQL session history
- 🚀 **Fully Deployed** — Docker backend on HF Spaces, React frontend on Vercel

---

## NLP Pipeline

Each answer is scored using a weighted combination of 4 models:

| Metric | Model | What it measures |
|--------|-------|-----------------|
| **Semantic Relevance** | `SBERT all-MiniLM-L6-v2` | Cosine similarity between question & answer embeddings |
| **Sentiment & Confidence** | `DistilBERT finetuned-sst-2` | Positive/confident tone detection |
| **Keyword Match** | `NLTK` (lemmatizer + tokenizer) | Domain-specific technical vocabulary coverage |
| **Clarity & Delivery** | Custom heuristics + `pydub` | Sentence structure, filler words, speaking pace (WPM) |

> All models are **open-source and free** — downloaded once and baked into the Docker image at build time. No API keys, no per-request billing.

---

## Architecture

```
┌──────────────────────┐         ┌────────────────────────────────┐
│   Vercel (Frontend)  │──HTTPS─▶│  Hugging Face Spaces (Backend) │
│   React + TypeScript │         │  FastAPI · Docker · Python 3.10 │
│   Tailwind CSS       │         │  SBERT · DistilBERT · NLTK      │
└──────────────────────┘         └────────────────────────────────┘
          │                                      │
          ▼                                      ▼
┌──────────────────────┐           Pre-loaded ML Models
│  Supabase            │           (baked into image at build time)
│  Auth · PostgreSQL   │
└──────────────────────┘
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | React 18, TypeScript, Vite, Tailwind CSS, Axios |
| **Backend** | FastAPI, Uvicorn, Python 3.10 |
| **NLP / AI** | Sentence-Transformers (SBERT), HuggingFace Transformers (DistilBERT), NLTK |
| **Audio** | SpeechRecognition (Google API), pydub, ffmpeg |
| **Database & Auth** | Supabase, PostgreSQL (Row-Level Security) |
| **DevOps** | Docker, Hugging Face Spaces, Vercel |

---

## Local Setup

### Prerequisites
- Python 3.10+ and Node.js 18+
- Unzip `sbert_model.zip` → `sbert_model/` in the project root (**required**)

### 1. Backend
```bash
pip install -r backend/requirements.txt
uvicorn backend.app:app --reload --port 8000
```

### 2. Frontend
```bash
cd frontend
npm install
npm run dev
```

Create `frontend/.env`:
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_API_URL=http://localhost:8000
```

---

## API Reference

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/` | Health check |
| `GET` | `/questions?category=Technical&count=7` | Fetch interview questions |
| `POST` | `/analyze` | Score a single answer |
| `POST` | `/analyze-session` | Batch score a full interview session |

---

## Project Structure

```
├── backend/
│   ├── app.py              # FastAPI routes & middleware
│   └── requirements.txt
├── analyzer.py             # Core NLP scoring engine
├── question_bank.json      # 250+ curated interview questions
├── sbert_model/            # Local SBERT weights (unzip from .zip)
├── weights.pkl             # Scoring weights for text vs audio modes
├── Dockerfile              # Docker build for HF Spaces
└── frontend/
    ├── src/services/api.ts # Typed Axios API client
    └── .env                # Environment variables
```

---

<div align="center">

Made by **Repalle Sai Nitish** · [GitHub](https://github.com/nitish-2812) · [LinkedIn](https://linkedin.com/in/nitish-2812)

</div>
