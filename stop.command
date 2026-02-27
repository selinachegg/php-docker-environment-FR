#!/bin/bash
# ============================================================
#  stop.command — Arrêter l'environnement PHP
#  Double-cliquez sur ce fichier pour arrêter tous les services
# ============================================================

cd "$(dirname "$0")"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║    Environnement PHP Docker — Arrêt      ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "⏳  Arrêt des services en cours..."
echo ""

docker compose stop

echo ""
echo "✅  Tous les services sont arrêtés."
echo "    Vos fichiers et données sont conservés."
echo ""
read -p "Appuyez sur Entrée pour fermer..."
