<html>
</head>
<form action="crypt-apache.php" method="POST">
<input type="password" name="pass">
<input type="submit" name="cripter">
</form>
</head>
</html>

<?
$pass_decrypt = $_POST['pass'];
$pass_crypt = crypt($_POST['pass']);
if(empty($pass_decrypt)) {
echo("Veuillez entrer un mot de passe a crypter");
exit();
}
echo("<br>Mot de pass non cypter : $pass_decrypt");
echo("<br>Mot de pass crypter : $pass_crypt");
?>

