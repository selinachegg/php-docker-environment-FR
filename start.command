#!/bin/bash
# ============================================================
#  start.command — Lancer l'environnement PHP
#  Double-cliquez sur ce fichier pour démarrer tous les services
# ============================================================

# Aller dans le dossier du projet (même si lancé depuis Finder)
cd "$(dirname "$0")"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Environnement PHP Docker — Démarrage   ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Vérifier que Docker Desktop est lancé
if ! docker info > /dev/null 2>&1; then
    echo "⚠️  Docker Desktop n'est pas démarré !"
    echo ""
    echo "   → Ouvrez Docker Desktop et attendez qu'il soit prêt"
    echo "   → Puis relancez ce fichier"
    echo ""
    read -p "Appuyez sur Entrée pour fermer..."
    exit 1
fi

echo "✅  Docker Desktop est prêt"
echo ""
echo "⏳  Démarrage des services..."
echo ""

# Lancer tous les conteneurs
docker compose up -d

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           Services disponibles           ║"
echo "╠══════════════════════════════════════════╣"
echo "║  🌐  Site PHP    → localhost:8080        ║"
echo "║  🗄️   phpMyAdmin → localhost:8081        ║"
echo "║  🐳  Portainer   → localhost:9000        ║"
echo "║  🏠  Dashboard   → localhost:8082        ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Attendre que les services soient prêts
echo "⏳  Attente du démarrage complet..."
sleep 5

# Ouvrir le tableau de bord dans le navigateur
echo "🚀  Ouverture du tableau de bord..."
open "http://localhost:8082"

echo ""
echo "✅  Environnement démarré avec succès !"
echo "    Vous pouvez fermer cette fenêtre."
echo ""
read -p "Appuyez sur Entrée pour fermer..."
