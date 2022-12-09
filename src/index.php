<?php
session_start(); //initiate / open session
$_SESSION['count'] = 0; // store something in the session
session_write_close(); //now close it,
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <h1>My PHP file</h1>
  <ul>
    <li>MEMCACHIER_USERNAME: <?php echo getenv("MEMCACHIER_USERNAME"); ?></li>
    <li>MEMCACHIER_PASSWORD: <?php echo getenv("MEMCACHIER_PASSWORD"); ?></li>
    <li>MEMCACHIER_SERVERS: <?php echo getenv("MEMCACHIER_SERVERS"); ?></li>
  </ul>
  <?php phpinfo(); ?>
</body>
</html>