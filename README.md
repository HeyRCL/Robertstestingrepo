# Nail Studio App

This repository contains a minimal end-to-end example for a nail studio web app.
It provides:

- A static frontend served from **Google Cloud Storage**.
- A Python backend deployed to **Cloud Run** responding to API requests.
- A `Makefile` to deploy both pieces with `make install`.

## Architecture

```
[Browser] --calls--> [Cloud Storage Website (frontend)] --fetch--> [Cloud Run (backend)]
```

1. The frontend is a static website (HTML + JS) that can be hosted in a GCS bucket.
2. The backend is a small Flask app exposed via Cloud Run. It returns a greeting
   based on the `name` sent from the frontend.
3. The frontend uses JavaScript `fetch` to call the backend and displays the result.

## Deploy

Set the variables for your project and run:

```bash
PROJECT_ID=my-project \\
REGION=us-central1 \\
make install
```

The script will:

1. Deploy the backend to Cloud Run.
2. Create or update a bucket for the frontend and upload the static files.
3. Print the URLs for both the frontend and backend.

After deployment you can open the printed frontend URL in your browser.

## Local development

- `backend/` contains the Cloud Run service.
- `frontend/` contains the static site files.

You can run the backend locally with:

```bash
pip install -r backend/requirements.txt
python backend/main.py
```

Then open `frontend/index.html` directly in a browser and adjust `script.js` to
point to `http://localhost:8080/hello` for local testing.
