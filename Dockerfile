FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev curl && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 appuser

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ .

USER root
RUN mkdir -p instance && chown appuser:appuser instance
USER appuser

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

EXPOSE 5000
CMD ["python", "app.py"]