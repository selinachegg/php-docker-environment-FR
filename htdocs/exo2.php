<?php
$a = 10;
$b = 5;
$operation = "+";

if ($operation == "+") {
    echo $a + $b;
} elseif ($operation == "-") {
    echo $a - $b;
} elseif ($operation == "*") {
    echo $a * $b;
} elseif ($operation == "/") {
    echo $a / $b;
} else {
    echo "Opération invalide";
}
?>