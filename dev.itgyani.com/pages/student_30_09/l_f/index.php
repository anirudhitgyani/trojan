<?php
$fb = new Facebook\Facebook([
  'app_id' => '1280237475343277', // Replace {app-id} with your app id
  'app_secret' => 'f17ad6b49694fb48ddb04ee3cb9ef190',
  'default_graph_version' => 'v2.2',
  ]);

$helper = $fb->getRedirectLoginHelper();

$permissions = ['email']; // Optional permissions
$loginUrl = $helper->getLoginUrl('http://www.itgyani.com/fb-callback.php', $permissions);

echo '<a href="' . htmlspecialchars($loginUrl) . '">Log in with Facebook!</a>';

?>