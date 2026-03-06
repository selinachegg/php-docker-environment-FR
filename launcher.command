#!/bin/bash
# ============================================================
#  launcher.command — Launcher principal
#  Double-cliquez sur ce fichier pour gerer l'environnement
# ============================================================

cd "$(dirname "$0")"

show_menu() {
    echo ""
    echo "=========================================="
    echo "   Environnement PHP Docker — Launcher"
    echo "=========================================="
    echo ""
    echo "  Apache 2.4 | PHP 7.4 | MariaDB 10.6"
    echo "  phpMyAdmin  | Portainer"
    echo ""
    echo "  1)  Demarrer"
    echo "  2)  Arreter"
    echo "  3)  Redemarrer"
    echo "  4)  Reset Portainer"
    echo "  5)  Quitter"
    echo ""
}

check_docker() {
    if ! docker info > /dev/null 2>&1; then
        echo ""
        echo "  Docker Desktop n'est pas demarre !"
        echo "  Ouvrez Docker Desktop, attendez l'icone baleine verte,"
        echo "  puis relancez."
        echo ""
        read -p "  Appuyez sur Entree pour continuer..."
        return 1
    fi
    return 0
}

while true; do
    clear
    show_menu
    read -p "  Votre choix [1-5] : " choice

    case "$choice" in
        1)
            check_docker || continue
            echo ""
            echo "  Demarrage en cours..."
            echo ""
            docker compose up -d
            if [ $? -eq 0 ]; then
                sleep 3
                open http://localhost:8082
                echo ""
                echo "  Environnement demarre !"
                echo ""
                echo "  Site PHP :       localhost:8080"
                echo "  phpMyAdmin :     localhost:8081"
                echo "  Portainer :      localhost:9000"
                echo "  Dashboard :      localhost:8082"
            else
                echo ""
                echo "  Erreur au demarrage. Verifiez Docker Desktop."
            fi
            echo ""
            read -p "  Appuyez sur Entree pour revenir au menu..."
            ;;
        2)
            echo ""
            echo "  Arret en cours..."
            echo ""
            docker compose stop
            if [ $? -eq 0 ]; then
                echo ""
                echo "  Environnement arrete proprement."
                echo "  Vos fichiers PHP et donnees sont conserves."
            else
                echo ""
                echo "  Erreur a l'arret."
            fi
            echo ""
            read -p "  Appuyez sur Entree pour revenir au menu..."
            ;;
        3)
            check_docker || continue
            echo ""
            echo "  Redemarrage en cours..."
            echo ""
            docker compose down
            docker compose up -d
            if [ $? -eq 0 ]; then
                sleep 3
                echo ""
                echo "  Environnement redemarre !"
                echo ""
                echo "  Site PHP :       localhost:8080"
                echo "  phpMyAdmin :     localhost:8081"
                echo "  Portainer :      localhost:9000"
                echo "  Dashboard :      localhost:8082"
            else
                echo ""
                echo "  Erreur au redemarrage. Verifiez Docker Desktop."
            fi
            echo ""
            read -p "  Appuyez sur Entree pour revenir au menu..."
            ;;
        4)
            echo ""
            echo "  Reinitialisation de Portainer..."
            echo "  (Les fichiers PHP et la BDD ne sont PAS supprimes)"
            echo ""
            docker compose stop portainer
            docker volume rm cours_portainer_data 2>/dev/null
            docker compose up -d portainer
            if [ $? -eq 0 ]; then
                sleep 2
                open http://localhost:9000
                echo ""
                echo "  Portainer reinitialise !"
                echo "  Allez sur localhost:9000 MAINTENANT"
                echo "  pour creer un nouveau compte admin."
            else
                echo ""
                echo "  Erreur reinitialisation Portainer."
            fi
            echo ""
            read -p "  Appuyez sur Entree pour revenir au menu..."
            ;;
        5|q|Q)
            echo ""
            echo "  Au revoir !"
            echo ""
            exit 0
            ;;
        *)
            echo ""
            echo "  Choix invalide. Entrez un chiffre entre 1 et 5."
            sleep 1
            ;;
    esac
done
