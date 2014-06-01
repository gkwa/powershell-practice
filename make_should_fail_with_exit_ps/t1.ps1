function fDefined()
{
    Write-Host "today"
    fNotDefined

    Write-Host "tomorrow"
}

Try
{
    fDefined
}

Catch
{
    Write-Host "catch"
}

Finally
{
    Write-Host "done"
    Exit 1
}
