<?php
echo "<h1>Bonjour 👋</h1>";
echo "<p>PHP fonctionne correctement !</p>";

// Afficher infos PHP
echo "<h2>Infos serveur</h2>";
echo "Version PHP : " . phpversion() . "<br>";
echo "Système : " . php_uname() . "<br>";

// Test connexion base de données
echo "<h2>Test connexion base de données</h2>";

try {
    $pdo = new PDO(
        "mysql:host=db;dbname=app;charset=utf8mb4",
        "app",
        "app",
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );

    echo "✅ Connexion réussie à la base de données !";

} catch (Exception $e) {
    echo "❌ Erreur de connexion : " . htmlspecialchars($e->getMessage());
}
?>