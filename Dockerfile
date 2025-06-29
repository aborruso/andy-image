# Dockerfile
FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1
# ➊ add ~/.local/bin to PATH: uv puts stand-alone tools here
ENV PATH="/root/.local/bin:${PATH}"

# ➋ system packages useful for scraping
RUN apt-get update && apt-get install -y \
    chromium curl wget jq miller xmlstarlet \
    && rm -rf /var/lib/apt/lists/*

# ➌ install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# ➍ install scrape-cli, yq, flatterer, frictionless as stand-alone tools
RUN uv tool install scrape-cli
RUN uv tool install yq
RUN uv tool install flatterer
RUN uv tool install frictionless
RUN uv tool install ckanapi
RUN uv tool install visidata

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

# ➒ install xan (latest release, x86_64-unknown-linux-musl)
RUN set -eux; \
    XAN_URL=$(curl -s https://api.github.com/repos/medialab/xan/releases/latest | \
      grep browser_download_url | grep x86_64-unknown-linux-musl.tar.gz | cut -d '"' -f 4); \
    echo "XAN_URL: $XAN_URL"; \
    if [ -z "$XAN_URL" ]; then echo "XAN_URL not found"; exit 1; fi; \
    curl -L "$XAN_URL" -o /tmp/xan.tar.gz; \
    tar -xzf /tmp/xan.tar.gz -C /tmp; \
    mv /tmp/xan /usr/local/bin/xan; \
    chmod +x /usr/local/bin/xan; \
    rm /tmp/xan.tar.gz
