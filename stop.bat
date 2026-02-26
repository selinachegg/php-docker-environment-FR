@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +==========================================+
echo  ^|   Environnement PHP Docker - Arret      ^|
echo  +==========================================+
echo.
echo  Arret des services en cours...
echo.

docker compose stop

echo.
echo  [OK] Tous les services sont arretes.
echo       Vos fichiers PHP et donnees sont conserves.
echo.
pause
