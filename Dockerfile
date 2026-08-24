# Stage 1: installation des dépendances
FROM python:3.12-slim as builder

WORKDIR /app

# Évite les fichiers .pyc et permet de voir les logs immédiatement
ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

COPY pyproject.toml .

RUN python -m venv /opt/venv \
  && /opt/venv/bin/pip install --upgrade pip \
  && /opt/venv/bin/pip install .

#Stage 2: image finale 
FROM python:3.12-slim as runtime

WORKDIR /app

ENV PATH="/opt/venv/bin/:$PATH" \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

COPY --from=builder /opt/venv /opt/venv
COPY app ./app

EXPOSE 8000

CMD [ "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000" ]

