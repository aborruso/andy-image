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

View the package at: <https://github.com/aborruso/andy-image/pkgs/container/andy-image>

---

**Note for repositories using this image**: Although this Docker image already has Git configured with `git config --global --add safe.directory '*'`, when you use this image in your own GitHub Actions workflows, this configuration might not propagate correctly between different execution contexts. To ensure Git operations work properly in all steps of your workflow, add this configuration to your repository's workflow:

```yaml
      - name: Set git safe directory
        run: git config --global --add safe.directory ${GITHUB_WORKSPACE}
```

This explicitly marks the GitHub Actions workspace as a safe directory for Git operations in the workflow environment.
