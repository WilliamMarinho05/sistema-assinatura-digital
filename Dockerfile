FROM python:3.12-slim
# Instala dependências de sistema para criptografia
RUN apt-get update && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev curl && rm -rf /var/lib/apt/lists/*

# Cria um usuário não-root para segurança
RUN useradd -m -u 1000 appuser

WORKDIR /app

# 1. Copia o requirements da raiz para o container
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Copia o conteúdo da pasta backend para o container
COPY backend/ .

# 3. Ajuste de permissões para o SQLite (Corrigido)
USER root
RUN mkdir -p instance && chown appuser:appuser instance
USER appuser

# 4. Adiciona o healthcheck (que você já tinha)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

EXPOSE 5000
CMD ["python", "app.py"]