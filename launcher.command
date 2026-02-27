#!/bin/bash
cd "$(dirname "$0")"

show_error() {
    osascript 2>/dev/null <<EOF
display dialog "$1" with title "Environnement PHP Docker" buttons {"OK"} default button "OK" with icon stop
EOF
}

show_success() {
    osascript 2>/dev/null <<EOF
display dialog "$1" with title "Environnement PHP Docker" buttons {"OK"} default button "OK" with icon note
EOF
}

while true; do
    ACTION=$(osascript 2>/dev/null <<'MENU'
set choices to {"▶  Demarrer", "■  Arreter", "↻  Redemarrer", "🔄  Reset Portainer", "✕  Quitter"}
set selected to choose from list choices with title "Environnement PHP Docker" with prompt "Apache 2.4   PHP 7.4   MariaDB 10.6
phpMyAdmin   Portainer

Choisissez une action :" default items {"▶  Demarrer"}
if selected is false then return "quitter"
return item 1 of selected
MENU
    )

    case "$ACTION" in
        *"Redemarrer"*)
            if ! docker info >/dev/null 2>&1; then
                show_error "Docker Desktop n'est pas demarre !

Ouvrez Docker Desktop, attendez l'icone baleine verte, puis relancez."
                continue
            fi
            osascript -e 'display dialog "Redemarrage en cours... Patientez." with title "Environnement PHP Docker" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose down 2>&1
            docker compose up -d 2>&1
            if [ $? -eq 0 ]; then
                sleep 3
                show_success "Environnement redemarre !

Site PHP :        localhost:8080
phpMyAdmin :  localhost:8081
Portainer :      localhost:9000
Dashboard :    localhost:8082"
            else
                show_error "Erreur au redemarrage. Verifiez Docker Desktop."
            fi
            ;;
        *"Demarrer"*)
            if ! docker info >/dev/null 2>&1; then
                show_error "Docker Desktop n'est pas demarre !

Ouvrez Docker Desktop, attendez l'icone baleine verte, puis relancez."
                continue
            fi
            osascript -e 'display dialog "Demarrage en cours... Patientez." with title "Environnement PHP Docker" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose up -d 2>&1
            if [ $? -eq 0 ]; then
                sleep 3
                open http://localhost:8082
                show_success "Environnement demarre !

Site PHP :        localhost:8080
phpMyAdmin :  localhost:8081
Portainer :      localhost:9000
Dashboard :    localhost:8082"
            else
                show_error "Erreur au demarrage. Verifiez Docker Desktop."
            fi
            ;;
        *"Arreter"*)
            docker compose down 2>&1
            if [ $? -eq 0 ]; then
                show_success "Environnement arrete proprement.

Vos fichiers PHP et donnees sont conserves."
            else
                show_error "Erreur a l'arret."
            fi
            ;;
        *"Portainer"*)
            osascript -e 'display dialog "Reinitialisation de Portainer... Patientez." with title "Environnement PHP Docker" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose stop portainer 2>&1
            docker volume rm cours_portainer_data 2>&1
            docker compose up -d portainer 2>&1
            if [ $? -eq 0 ]; then
                sleep 2
                open http://localhost:9000
                show_success "Portainer reinitialise !

Allez sur localhost:9000 MAINTENANT pour creer un nouveau compte admin."
            else
                show_error "Erreur reinitialisation Portainer."
            fi
            ;;
        *"Quitter"*|*"quitter"*|"")
            exit 0
            ;;
    esac
done
