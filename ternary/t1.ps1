$quantity=1
$price=2

$total = ($quantity * $price ) * ({$quantity -le 10} ? {.9} : {.75})
$total