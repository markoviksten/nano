#!/bin/bash
set -e

echo "Käynnistetään virtuaalinen X-serveri (Xvfb)..."
Xvfb :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &
XVFB_PID=$!

# Odotetaan että Xvfb on todella valmis
echo "Odotetaan että Xvfb käynnistyy..."
for i in {1..30}; do
    if xdpyinfo -display :99 >/dev/null 2>&1; then
        echo "✓ Xvfb käynnissä ja vastaa (PID: $XVFB_PID)"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "❌ VIRHE: Xvfb ei käynnistynyt 30 sekunnissa!"
        exit 1
    fi
    echo "  Odotetaan... ($i/30)"
    sleep 1
done

echo "Patchataan graph_visualizer.py yhteensopivaksi..."
/app/patch_visualizer.sh

echo "Käynnistetään Streamlit..."

# Käynnistä Streamlit
exec python -m streamlit run graph_visualizer.py --server.port=8501 --server.address=0.0.0.0