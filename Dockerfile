FROM docker.io/astral/uv:python3.9-trixie

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

WORKDIR /app

# 1. Copia i file di configurazione (per sfruttare la cache di Docker)
# Se cambiano solo i sorgenti, uv non riscaricherà le dipendenze
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-install-project --no-dev

RUN uv run playwright install --with-deps

COPY . .