# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Beginner-friendly PHP Docker environment (XAMPP replacement) for a database course. Single HTML tutorial (`TUTORIEL-ETUDIANTS.html`) with Mac/Windows variants, powered by Docker Compose.

## Stack

- PHP 7.4 + Apache 2.4 (custom Dockerfile)
- MariaDB 10.6
- phpMyAdmin 5.2, Portainer CE, Nginx dashboard
- Docker Compose v3.8

## Commands

```bash
# Start/stop (or double-click start.bat / start.command)
docker compose up -d
docker compose stop

# Full reset (destroys data)
docker compose down -v

# Restart a single service
docker compose restart portainer

# Logs
docker compose logs -f web
```

Mac first-time only: `chmod +x start.command stop.command`

## Architecture

Five containers on a shared `cours-network` bridge:

| Service | Port | Role |
|---------|------|------|
| web | 8080 | Apache+PHP, serves `htdocs/` |
| db | internal | MariaDB (host=`db` from PHP) |
| phpmyadmin | 8081 | DB admin UI |
| portainer | 9000 | Docker GUI |
| dashboard | 8082 | Static landing page (`dashboard/index.html`) |

Volumes: `mysql_data` (DB persistence), `portainer_data`. The `htdocs/` and `config/php.ini` directories are bind-mounted — changes are instant, no rebuild needed.

## Credentials

DB root password: `root` | App user: `app` / `app` | Database name: `app`

PHP connection host is `db` (Docker service name), not `localhost`.

## Key Files

- **`TUTORIEL-ETUDIANTS.html`** — Self-contained tutorial (HTML+CSS+JS). Has OS selector (Mac/Win), print-optimized `@media print` CSS with `break-inside: avoid` rules for PDF export. **Do not break the print layout when editing.**
- **`Dockerfile`** — PHP 7.4-Apache with PDO, MySQL, GD, ZIP, MBString, XML, OPcache extensions.
- **`config/php.ini`** — Development-mode config: errors visible, 64MB uploads, Europe/Paris timezone.
- **`dashboard/index.html`** — Landing page hub linking all services.
- **`start.bat` / `start.command`** — Launch scripts that check Docker, run `docker compose up -d`, open dashboard.
- **`reset-portainer.bat`** — Resets Portainer auth volume (5-min timeout issue).

## Tutorial HTML Print CSS

The `@media print` section in `TUTORIEL-ETUDIANTS.html` is carefully tuned:
- `@page { size: A4; margin: 18mm; }` — provides margins and space for browser headers/footers
- All pedagogical blocks (`.step`, `.alert`, `.card`, `.tbl`, `pre`, etc.) have `break-inside: avoid`
- `.page-break` class forces chapter breaks
- `.g2` grid flattens to single-column in print
- `.ch-header` negative margins are removed in print (replaced with `border-radius: 10px`)
- `.page` and `.page-content` padding set to 0 in print (margins handled by `@page`)

When modifying the tutorial, always test PDF export via Chrome/Edge "Save as PDF".
