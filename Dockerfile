# Dockerfile
FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1
# ➊ aggiungiamo ~/.local/bin al PATH: qui uv mette i tool “stand-alone”
ENV PATH="/root/.local/bin:${PATH}"

# ➋ pacchetti di sistema utili per scraping
RUN apt-get update && apt-get install -y \
    chromium curl wget jq miller \
    && rm -rf /var/lib/apt/lists/*

# ➌ installiamo uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# ➍ installiamo scrape-cli come tool indipendente
RUN uv tool install scrape-cli

# ➎ librerie Python condivise
RUN pip install \
    requests beautifulsoup4 playwright==1.44.0

# ➏ directory di lavoro
WORKDIR /workspace

# ➐ installiamo Node.js (da NodeSource) e i pacchetti npm globali
RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g puppeteer playwright \
    && rm -rf /var/lib/apt/lists/*
