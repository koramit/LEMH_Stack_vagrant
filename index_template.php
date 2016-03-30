<html>
<head>
	<title>Test Vagrant</title>
</head>
<body>

	<h1>Hello Vagrant.</h1>
	<hr>
	
	<?php
	// Connect to MariaDB.
	$link = mysql_connect('localhost','root', 'mdb@dev');
	// Check connection.
	if (!$link) {
	    die('Could not connect: ' . mysql_error());
	}
	// Print MariaDB info.
	printf("MySQL server version: %s\n", mysql_get_server_info());
	?>
	<hr>

	<?php
	// Show php info.
	phpinfo();
	?>
</body>
</html>