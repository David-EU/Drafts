<html>
</head>
<form action="crypt-md5.php" method="POST">
<input type="password" name="pass">
<input type="submit" name="cripter">
</form>
</head>
</html>

<?
$pass_decrypt = $_POST['pass'];
$pass_crypt = md5($_POST['pass']);
if(empty($pass_decrypt)) {
echo("Veuillez entrer un mot de passe a crypter");
exit();
}
echo("<br>Mot de pass non cypte : $pass_decrypt");
echo("<br>Mot de pass crypte : $pass_crypt");
?>

