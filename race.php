<?php
//This is the main script, present this to the public internet
include('config.php');
include('technika.class.php');

$Technika = new Technika($_config['mysql_server'],$_config['mysql_user'],$_config['mysql_pass'],$_config['mysql_db']);

?>

<html>
<head>
    <title>Crew Race Simulator</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<?php
$Technika->load_songs();

$Technika->gui_race();
?>
</body>
</html>
