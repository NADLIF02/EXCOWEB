<?php
$username = $_POST['username'];
$password = $_POST['password'];

// Connexion à la base de données (ex: MySQL)
$mysqli = new mysqli("localhost", "votre_utilisateur", "votre_mot_de_passe", "nom_de_la_base");

if ($mysqli->connect_error) {
    die("Connexion échouée : " . $mysqli->connect_error);
}

// Vérifiez les identifiants dans la base de données
$query = "SELECT * FROM utilisateurs WHERE username = ? AND password = ?";
$stmt = $mysqli->prepare($query);
$stmt->bind_param("ss", $username, $password);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    echo "Connexion réussie";
} else {
    echo "Identifiants incorrects";
}
$stmt->close();
$mysqli->close();
?>
