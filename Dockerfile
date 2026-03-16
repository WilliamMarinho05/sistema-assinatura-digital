FROM python:3.12-slim@sha256:SPECIFIC_DIGEST_HERE

# Instala dependências de sistema para criptografia
RUN apt-get update && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev curl && rm -rf /var/lib/apt/lists/*

# Cria um usuário não-root para segurança
RUN useradd -m -u 1000 appuser

WORKDIR /app
COPY . .

# Instala as bibliotecas necessárias com versões pinadas
RUN pip install --no-cache-dir flask==3.0.0 flask-sqlalchemy==3.1.1 cryptography==41.0.7

# Define o usuário não-root
USER appuser

# Adiciona healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

EXPOSE 5000
CMD ["python", "app.py"]