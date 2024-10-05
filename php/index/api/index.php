<?php
$headers =  getallheaders();
$arr = [];

foreach ($headers as $key => $val) {
  $arr[$key] = $val;
}

header('Content-Type: application/json');
echo json_encode($arr);
