<?php
session_start();
$_SESSION['test'] = "Session test var D";
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
  <div>Session test value: <?php echo $_SESSION['test']; ?></div>
  <ul>
    <li>MEMCACHIER_USERNAME: <?php echo getenv("MEMCACHIER_USERNAME"); ?></li>
    <li>MEMCACHIER_SERVERS: <?php echo getenv("MEMCACHIER_SERVERS"); ?></li>
  </ul>
  <?php phpinfo(); ?>
</body>
</html>