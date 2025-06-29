# andy-image

This Docker image provides a ready-to-use environment for data scraping, web automation, and data processing. It includes:

- Python 3.12 with libraries: requests, beautifulsoup4, playwright, requests-aws4auth
- Chromium browser for headless browsing
- Node.js (via NodeSource) with global installation of puppeteer and playwright
- System tools: curl, wget, jq, miller, xmlstarlet, git
- Stand-alone tools (via uv): scrape-cli, yq, flatterer, frictionless, ckanapi, visidata
- duckdb (installed via official script)
- xan (latest release, installed from GitHub)

The image is designed for flexible data workflows, combining Python, Node.js, and CLI tools for scraping and data transformation tasks.

## Usage

You can pull and use this image with:

```bash
docker pull ghcr.io/aborruso/andy-image:latest
```

See the package at: <https://github.com/aborruso/andy-image/pkgs/container/andy-image>

Note: put these instructions in the workflow of the repo tha will use this image:

```yaml
      - name: Set git safe directory
        run: git config --global --add safe.directory ${GITHUB_WORKSPACE}
```

In this way, you can use the image in your GitHub Actions workflows without issues related to Git's safe directory settings.
