# ---------- Base Image ----------
FROM python:3.11-slim

# Disable buffering for logs
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app/

# ---------- System Dependencies ----------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# ---------- Install uv (modern dependency manager) ----------
RUN pip install --no-cache-dir uv

# ---------- Copy and Install Dependencies ----------
COPY requirements.txt ./
RUN --mount=type=cache,target=/root/.cache/uv uv pip install --system -r requirements.txt

# ---------- Copy Application Files ----------
#COPY ./src ./src
COPY main.py ./

# ---------- Run the App ----------
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
