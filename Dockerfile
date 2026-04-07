# FROM python:3.10-slim-trixie AS base
# LABEL org.opencontainers.image.source="https://github.com/sbOogway/internet_archive_downloader"

# ARG APP_DIR=/usr/src/app

# RUN mkdir $APP_DIR

# WORKDIR $APP_DIR

# COPY . $APP_DIR

# RUN pip install -r requirements.txt

# ENTRYPOINT [ "python3", "archive-org-downloader.py" ]

FROM docker.io/astral/uv:python3.9-trixie

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

WORKDIR /app

# 1. Copia i file di configurazione (per sfruttare la cache di Docker)
# Se cambiano solo i sorgenti, uv non riscaricherà le dipendenze
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-install-project --no-dev

# 3. Copia il resto del codice sorgente
COPY . .

# 4. Installa il progetto stesso (se definito come package nel pyproject)
RUN uv sync --frozen --no-dev

# Usa 'uv run' per eseguire lo script nell'ambiente gestito da uv
ENTRYPOINT [ "uv", "run", "archive-org-downloader.py" ]