<div align="center">
# 🚀🚀🚀 Nano  - Simple & Fast Knowledge Graph RAG Solution

# local environment setup

1.

- install bash
- install docker (or podman)
- install vscode ( devaamiseen )


2.

mkdir nano
start bash

git clone https://github.com/markoviksten/nano2.git
cd nano2

mkdir -p data/nano{1..5}/{rag_storage,inputs}
mkdir -p agent/data/agent{1..5}
touch config.ini

cp env.example .env

EDIT .env : add following to there (copy-paste / huom openai api key tarvitaan! rerank jina apikey free käytössä)

env filu tähän kohtaan!

(muista käynnistää podman koneellasi: sitten aja asennus)
docker compose up -d

DONE!!

Verify that url respond now : 
Nano Agent http://localhost:9001/docs#/ - http://localhost:9005/docs#/
LightRAG http://localhost:9621/webui/ - http://localhost:9625/webui/
App UI  http://localhost:3000/

//// aftercare config - configuration guide : later-on finalized
webui webhook: https://169.51.48.29:5678/webhook/08149cd3-53bc-449b-a8ec-a54a2e68b770
put testiyhteys.json to n8n to serve this / reconfigure points corectly

CLOSE SYSTEM
docker compose down

huom asenna paikallinen n8n / ohessa esimerkki komento
podman run -it --rm   --name n8n   -p 5678:5678   -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true   -e N8N_RUNNERS_ENABLED=true   -e N8N_HOST=127.0.0.1   -e N8N_PORT=5678   -e N8N_PROTOCOL=http   -e N8N_COMMUNITY_PACKAGES_ENABLED=true   -v n8n_data:/home/node/.n8n   -v "C:\Users\861100702\Documents\n8n\n8n_data":/home/node/excel   --dns=8.8.8.8   --dns=8.8.4.4   docker.n8n.io/n8nio/n8n start

keycloak asennus & konffaus identiteetinhallintaan UI:ta varten?

# cloud environment setup

Saman tyyppinen set up cloudiin paitsi tilaat ensin IBM Cloud tililtä koneen mihin kaikke asennetaan,

1. Cloud Machine setup

2. Nano asennus cloudissa

loggaa sisään cloudi koneeseen
ssh@iposoite.ocm
yes
salasana


huom asenna cloud n8n / ohessa esimerkki komento (huomaa tarttet ip osoiteen isäntäkoneelta ensin)
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  -e N8N_RUNNERS_ENABLED=true \
  -e N8N_COMMUNITY_PACKAGES_ENABLED=true \
  -e N8N_HOST=169.51.48.29 \
  -e N8N_PORT=5678 \
  -e N8N_PROTOCOL=https \
  -e N8N_EDITOR_BASE_URL=https://169.51.48.29:5678 \
  -e WEBHOOK_URL=https://169.51.48.29:5678 \
  -e N8N_SSL_KEY=/certs/private.key \
  -e N8N_SSL_CERT=/certs/certificate.crt \
  -v n8n_data:/home/node/.n8n \
  -v ~/n8n/n8n_data:/home/node/excel \
  -v ~/n8n/certs:/certs \
  --dns=8.8.8.8 \
  --dns=8.8.4.4 \
  docker.n8n.io/n8nio/n8n start
