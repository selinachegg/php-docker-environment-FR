#!/bin/bash
# ============================================================
#  reset-portainer.command — Réinitialiser Portainer
#  Double-cliquez sur ce fichier pour réinitialiser Portainer
# ============================================================

cd "$(dirname "$0")"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Environnement PHP Docker — Reset       ║"
echo "║           Portainer                      ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "  Ce script supprime le compte Portainer et"
echo "  réinitialise l'interface."
echo "  (Les fichiers PHP et la BDD ne sont PAS supprimés)"
echo ""
read -p "Confirmer la réinitialisation ? (o/N) : " confirm

if [[ ! "$confirm" =~ ^[oO]$ ]]; then
    echo ""
    echo "  Annulé."
    echo ""
    read -p "Appuyez sur Entrée pour fermer..."
    exit 0
fi

echo ""
echo "⏳  Arrêt de Portainer..."
docker compose stop portainer

echo "🗑️   Suppression du volume Portainer..."
docker volume rm cours_portainer_data 2>/dev/null

echo "🚀  Redémarrage de Portainer..."
docker compose up -d portainer

echo ""
echo "✅  Portainer réinitialisé !"
echo ""
echo "  Allez MAINTENANT sur http://localhost:9000"
echo "  pour créer votre nouveau compte (5 minutes max)."
echo ""
open http://localhost:9000
read -p "Appuyez sur Entrée pour fermer..."
