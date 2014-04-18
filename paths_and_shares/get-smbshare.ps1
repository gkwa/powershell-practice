$pc = $ENV:Computername
net.exe view $pc | ForEach-Object {"$_"}
