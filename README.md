***

# TDS Project 1

A Flask-based web API for generic app dev via LLM, GitHub integration, and LLM-powered workflow orchestration.
Runs as a REST service and exposes endpoints for LLM tasks, with safe concurrency and robust automated deployment to GitHub.

***

## Features

- Accepts LLM tasks and file attachments via `/api-endpoint`
- Automatically creates/updates files and deploys repos on GitHub via the API
- Supports dual operation: local dev, Hugging Face Space, or Docker
- Advanced concurrency with a background worker queue (prevents API rate-limiting)
- API input/output is pure JSON for easy integration

***

## Setup (Hugging Face Space or Docker)

### Quickstart on Hugging Face Spaces

1. **Add your secrets (Hugging Face Space > Settings > Secrets):**
    - `GITHUB_TOKEN`: a personal access token (needs repo/fine-grained content permissions)
    - `GITHUB_USER`: your GitHub username
    - `AIPIPE_TOKEN`, `GEMINI_API_KEY`, `GOOGLE_FORM_SECRET`: (if using advanced features)
2. **Upload these files to your Space:**
    - `app.py`
    - `requirements.txt`
    - (Optional) `.github/` workflows directory (to enable deployment automation)
3. **Space will automatically start using:**

```shell
flask run --host=0.0.0.0 --port=7860
```


### Local Docker usage

1. Build and run the container:

```bash
docker build -t captcha-demo .
docker run -p 7860:7860 --env-file .env captcha-demo
```

    - Create a `.env` file with all required secrets as environment variables.

***

## Usage

### API Endpoint

- **URL:** `/api-endpoint` (POST)
- **Content-Type:** `application/json`
- **Body:**
    - Required fields: `"secret"` (`GOOGLE_FORM_SECRET`), `"task"` (unique id), attachments (base64-encoded), functional requirements.
    - See `data.json` schema (or test example) for expected format.
- **Typical request:**

```bash
curl -X POST https://<your-space>.hf.space/api-endpoint \
  -H "Content-Type: application/json" \
  -d @test_input.json
```


### Development Mode

- Start the server and interact locally:

```bash
python app.py
```


### Static Export

- Export a static site (for deployment):

```bash
python app.py --export
```


***

## Code Structure

- **app.py:**
    - Flask app and concurrency setup (two worker threads for incoming tasks)
    - Handles all incoming requests via `/api-endpoint` route
    - GitHub repo/file creation and updating via `upsert_github_file`
    - LLM orchestration using Gemini/OpenAI or Hugging Face (with retry safety)
    - Queue-based background workers for robust, rate-limited processing
    - Secrets and config handled via environment variables
- **requirements.txt:**
Standard Python dependencies: Flask, PyGithub, requests, google-genai, etc.
- **.github/**:
Optional directory for Actions workflows (build/test/deploy automation)
- **Dockerfile:** (as provided)
    - Uses `python:3.10-slim` with pip install, exposes port 7860
    - Starts Flask:

```
CMD ["flask", "run", "--host=0.0.0.0", "--port=7860"]
```


***

## Operational Tips

- **VPN/Proxy required for Hugging Face Spaces in some countries**
- **API usage is throttled by a background queue for rate limit safety**
- **GitHub automation will fail if token scope or secrets are misconfigured**
- All machine-generated content and deployments are flagged as AI/LLM-created for transparency

***

## License

MIT License.
Use, modify, and deploy as you see fit. No warranty, use at your own risk.

***

## Acknowledgements

This project was generated and orchestrated with Large Language Models for workflow, code, and documentation.
For questions, raise an issue or contact the author.

***

**Ready to run on Hugging Face Spaces or in Docker!**
<span style="display:none">[^1]</span>

<div align="center">⁂</div>

[^1]: paste.txt


