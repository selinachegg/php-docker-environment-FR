@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +============================================+
echo  ^|   Reset Portainer - Reinitialisation      ^|
echo  +============================================+
echo.
echo  Ce script supprime le compte Portainer et
echo  reinitialise l'interface (donnees PHP et BDD
echo  ne sont PAS supprimees).
echo.
set /p confirm="Confirmer la reinitialisation ? (O/N) : "
if /i "%confirm%" neq "O" (
    echo  Annule.
    pause
    exit /b 0
)

echo.
echo  Arret de Portainer...
docker compose stop portainer

echo  Suppression du volume Portainer...
docker volume rm cours_portainer_data 2>nul

echo  Redemarrage de Portainer...
docker compose up -d portainer

echo.
echo  [OK] Portainer reinitialise !
echo.
echo  Allez MAINTENANT sur http://localhost:9000
echo  pour creer votre nouveau compte (5 minutes max).
echo.
start http://localhost:9000
pause
