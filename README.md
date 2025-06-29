# andy-image

This Docker image provides a ready-to-use environment for data scraping, web automation, and data processing. It includes:

- Python 3.12 with libraries: requests, beautifulsoup4, playwright
- Chromium browser for headless browsing
- Node.js (via NodeSource) with global installation of puppeteer and playwright
- System tools: curl, wget, jq, miller
- scrape-cli, yq, flatterer, frictionless (installed as standalone tools via uv)
- duckdb (installed via official script)

The image is designed for flexible data workflows, combining Python, Node.js, and CLI tools for scraping and data transformation tasks.
