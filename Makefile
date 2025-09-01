PROJECT_ID ?= your-gcp-project
REGION ?= us-central1
SERVICE_NAME ?= nailstudio-backend
BUCKET_NAME ?= nailstudio-frontend-$(PROJECT_ID)

.PHONY: install
install:
@echo "Deploying Cloud Run service..."
gcloud run deploy $(SERVICE_NAME) --source backend --project $(PROJECT_ID) --region $(REGION) --allow-unauthenticated
@export API_URL=`gcloud run services describe $(SERVICE_NAME) --project $(PROJECT_ID) --region $(REGION) --format 'value(status.url)'` && \
mkdir -p .deploy && cp frontend/* .deploy/ && \
sed -i "s|__API_URL__|$$API_URL/hello|g" .deploy/script.js && \
gsutil mb -p $(PROJECT_ID) -l $(REGION) gs://$(BUCKET_NAME) || true && \
gsutil iam ch allUsers:objectViewer gs://$(BUCKET_NAME) && \
gsutil cp .deploy/* gs://$(BUCKET_NAME)/ && \
gsutil web set -m index.html -e 404.html gs://$(BUCKET_NAME) && \
rm -r .deploy && \
echo "Frontend URL: https://storage.googleapis.com/$(BUCKET_NAME)/index.html" && \
echo "Backend URL: $$API_URL/hello"
