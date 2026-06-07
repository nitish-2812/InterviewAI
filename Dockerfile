# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (needed for speech recognition, audio processing, etc.)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libavcodec-extra \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY backend/requirements.txt /app/

# Install Python dependencies
# We install torch CPU only to save space and time since Spaces uses CPU by default
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . /app/

# Pre-download NLTK data and models during the build process
RUN python -c "import nltk; nltk.download('stopwords'); nltk.download('wordnet'); nltk.download('punkt'); nltk.download('punkt_tab')"
RUN python -c "from transformers import pipeline; pipeline('sentiment-analysis', model='distilbert-base-uncased-finetuned-sst-2-english')"
RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('all-MiniLM-L6-v2')"

# Expose the port the app runs on (Hugging Face Spaces uses 7860)
EXPOSE 7860

# Command to run the application 
CMD ["uvicorn", "backend.app:app", "--host", "0.0.0.0", "--port", "7860"]
