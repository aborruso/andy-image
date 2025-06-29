# Dockerfile
FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1
# ➊ add ~/.local/bin to PATH: uv puts stand-alone tools here
ENV PATH="/root/.local/bin:${PATH}"

# ➋ system packages useful for scraping
RUN apt-get update && apt-get install -y \
    chromium curl wget jq miller \
    && rm -rf /var/lib/apt/lists/*

# ➌ install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# ➍ install scrape-cli, yq, flatterer, frictionless as stand-alone tools
RUN uv tool install scrape-cli
RUN uv tool install yq
RUN uv tool install flatterer
RUN uv tool install frictionless

# ➎ shared Python libraries
RUN pip install \
    requests beautifulsoup4 playwright==1.44.0

# ➏ working directory
WORKDIR /workspace

# ➐ install Node.js (from NodeSource) and global npm packages
RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g puppeteer playwright \
    && rm -rf /var/lib/apt/lists/*

# ➑ install duckdb
RUN curl https://install.duckdb.org | sh
