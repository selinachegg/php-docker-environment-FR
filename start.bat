@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +==========================================+
echo  ^|  Environnement PHP Docker - Demarrage   ^|
echo  +==========================================+
echo.

REM Verification Docker Desktop
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERREUR] Docker Desktop n'est pas demarre !
    echo.
    echo  Solution :
    echo    1. Ouvrez Docker Desktop depuis le menu Demarrer
    echo    2. Attendez l'icone baleine dans la barre des taches
    echo    3. Relancez ce fichier start.bat
    echo.
    pause
    exit /b 1
)

echo  [OK] Docker Desktop est pret
echo.
echo  Demarrage des services en cours...
echo.

docker compose up -d

if %errorlevel% neq 0 (
    echo.
    echo  [ERREUR] Probleme au demarrage. Verifiez Docker Desktop.
    pause
    exit /b 1
)

echo.
echo  +==========================================+
echo  ^|          Services disponibles           ^|
echo  +==========================================+
echo  ^|  Site PHP    -^> http://localhost:8080   ^|
echo  ^|  phpMyAdmin  -^> http://localhost:8081   ^|
echo  ^|  Portainer   -^> http://localhost:9000   ^|
echo  ^|  Dashboard   -^> http://localhost:8082   ^|
echo  +==========================================+
echo.
echo  Attente du demarrage complet (5 secondes)...
timeout /t 5 /nobreak >nul

echo.
echo  Ouverture du tableau de bord dans votre navigateur...
start http://localhost:8082

echo.
echo  [OK] Environnement demarre avec succes !
echo.
echo  IMPORTANT - Portainer (localhost:9000) :
echo    Si c'est votre premier lancement, allez sur
echo    http://localhost:9000 MAINTENANT pour creer
echo    votre compte (vous avez 5 minutes).
echo.
pause
