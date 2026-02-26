<?php
/**
 * index.php — Page de test de l'environnement PHP Docker
 * Affiche : version PHP, connexion base de données, infos système
 */

// ── Connexion à la base de données (via PDO) ──
$db_host     = getenv('DB_HOST')     ?: 'db';
$db_name     = getenv('DB_NAME')     ?: 'app';
$db_user     = getenv('DB_USER')     ?: 'app';
$db_password = getenv('DB_PASSWORD') ?: 'app';

$db_status  = '';
$db_class   = 'error';
$db_version = '';

try {
    $dsn = "mysql:host={$db_host};dbname={$db_name};charset=utf8mb4";
    $pdo = new PDO($dsn, $db_user, $db_password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_TIMEOUT => 3,
    ]);
    $db_version = $pdo->query("SELECT VERSION()")->fetchColumn();
    $db_status  = "✅ Connexion réussie ! (MariaDB {$db_version})";
    $db_class   = 'success';
} catch (PDOException $e) {
    $db_status = "❌ Erreur : " . htmlspecialchars($e->getMessage());
    $db_class  = 'error';
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello PHP — Environnement de cours</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0f172a;
            color: #e2e8f0;
            min-height: 100vh;
            padding: 2rem;
        }

        header {
            text-align: center;
            padding: 3rem 1rem 2rem;
        }

        header h1 {
            font-size: 3rem;
            background: linear-gradient(135deg, #6366f1, #06b6d4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        header p {
            color: #94a3b8;
            font-size: 1.1rem;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .card h2 {
            color: #6366f1;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .php-version {
            font-size: 2.5rem;
            font-weight: 700;
            color: #06b6d4;
        }

        .badge {
            display: inline-block;
            background: #0891b2;
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }

        .success {
            color: #34d399;
            font-size: 1.05rem;
            padding: 0.75rem;
            background: rgba(52, 211, 153, 0.1);
            border: 1px solid rgba(52, 211, 153, 0.3);
            border-radius: 8px;
        }

        .error {
            color: #f87171;
            font-size: 1.05rem;
            padding: 0.75rem;
            background: rgba(248, 113, 113, 0.1);
            border: 1px solid rgba(248, 113, 113, 0.3);
            border-radius: 8px;
        }

        .links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .link-btn {
            display: block;
            text-decoration: none;
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 10px;
            padding: 1.25rem;
            text-align: center;
            transition: all 0.2s;
            color: #e2e8f0;
        }

        .link-btn:hover {
            border-color: #6366f1;
            background: #243048;
            transform: translateY(-2px);
        }

        .link-btn .icon { font-size: 2rem; margin-bottom: 0.5rem; }
        .link-btn .title { font-weight: 600; color: #6366f1; }
        .link-btn .url { font-size: 0.8rem; color: #64748b; margin-top: 0.25rem; }

        .creds-table {
            width: 100%;
            border-collapse: collapse;
        }

        .creds-table tr:not(:last-child) {
            border-bottom: 1px solid #1e293b;
        }

        .creds-table td {
            padding: 0.6rem 0.5rem;
            font-size: 0.95rem;
        }

        .creds-table td:first-child {
            color: #94a3b8;
            width: 40%;
        }

        .creds-table td:last-child {
            font-family: 'Courier New', monospace;
            color: #06b6d4;
            font-weight: 600;
        }

        details {
            margin-top: 1rem;
        }

        summary {
            cursor: pointer;
            color: #6366f1;
            font-weight: 600;
            padding: 0.5rem 0;
            user-select: none;
        }

        summary:hover { color: #818cf8; }

        footer {
            text-align: center;
            color: #475569;
            font-size: 0.85rem;
            padding: 2rem 0;
        }
    </style>
</head>
<body>

<header>
    <h1>Hello PHP ! 👋</h1>
    <p>Votre environnement de développement est opérationnel</p>
</header>

<div class="container">

    <!-- ── Version PHP ── -->
    <div class="card">
        <h2>⚙️ Version PHP</h2>
        <div class="php-version">PHP <?= PHP_VERSION ?></div>
        <div class="badge"><?= PHP_OS ?> — <?= PHP_INT_SIZE * 8 ?> bits</div>
    </div>

    <!-- ── Connexion Base de données ── -->
    <div class="card">
        <h2>🗃️ Connexion à la base de données</h2>
        <p class="<?= $db_class ?>"><?= $db_status ?></p>

        <?php if ($db_class === 'success'): ?>
        <details>
            <summary>Voir les paramètres de connexion PDO</summary>
            <table class="creds-table" style="margin-top:0.75rem">
                <tr><td>DSN</td><td>mysql:host=db;dbname=app</td></tr>
                <tr><td>Utilisateur</td><td>app</td></tr>
                <tr><td>Mot de passe</td><td>app</td></tr>
            </table>
        </details>
        <?php endif; ?>
    </div>

    <!-- ── Liens rapides ── -->
    <div class="card">
        <h2>🔗 Accès rapides</h2>
        <div class="links-grid">
            <a class="link-btn" href="http://localhost:8080" target="_blank">
                <div class="icon">🌐</div>
                <div class="title">Mon site PHP</div>
                <div class="url">localhost:8080</div>
            </a>
            <a class="link-btn" href="http://localhost:8081" target="_blank">
                <div class="icon">🗄️</div>
                <div class="title">phpMyAdmin</div>
                <div class="url">localhost:8081</div>
            </a>
            <a class="link-btn" href="http://localhost:9000" target="_blank">
                <div class="icon">🐳</div>
                <div class="title">Portainer</div>
                <div class="url">localhost:9000</div>
            </a>
            <a class="link-btn" href="http://localhost:8082" target="_blank">
                <div class="icon">🏠</div>
                <div class="title">Dashboard</div>
                <div class="url">localhost:8082</div>
            </a>
        </div>
    </div>

    <!-- ── Identifiants BDD ── -->
    <div class="card">
        <h2>🔑 Identifiants base de données</h2>
        <table class="creds-table">
            <tr><td>Hôte (dans PHP)</td><td>db</td></tr>
            <tr><td>Base de données</td><td>app</td></tr>
            <tr><td>Utilisateur</td><td>app</td></tr>
            <tr><td>Mot de passe</td><td>app</td></tr>
            <tr><td>Mot de passe root</td><td>root</td></tr>
        </table>
    </div>

    <!-- ── Exemple de code PDO ── -->
    <div class="card">
        <h2>💡 Exemple de connexion PDO</h2>
        <pre style="background:#0f172a;padding:1rem;border-radius:8px;overflow-x:auto;font-size:0.9rem;color:#a5f3fc;line-height:1.6">&lt;?php
$pdo = new PDO(
    "mysql:host=db;dbname=app;charset=utf8mb4",
    "app",      // utilisateur
    "app"       // mot de passe
);
echo "Connexion réussie !";
?&gt;</pre>
    </div>

    <!-- ── phpinfo ── -->
    <div class="card">
        <h2>📋 Informations PHP complètes</h2>
        <details>
            <summary>Afficher phpinfo()</summary>
            <div style="margin-top:1rem">
                <?php phpinfo(); ?>
            </div>
        </details>
    </div>

</div>

<footer>
    <p>Environnement Docker — Apache <?= apache_get_version() ?> — PHP <?= PHP_VERSION ?></p>
</footer>

</body>
</html>
