Connect-AzAccount
Set-AzContext -Subscription "Nexa Resources"
$resources = Get-AzResource -TagName "E-mail" -TagValue "christianne.sabo@nexaresources.com" 
$Tags = @{"E-mail"="andre.moreira@nexaresources.com"}
$resources | ForEach-Object {
    Update-AzTag -ResourceId $_.ResourceId -Tag $Tags -Operation Merge
}

$deletedTags = @{"Responsavel"="ITO"}
$resources | foreach-object {
Update-AzTag -ResourceId $_.resourceid -Tag $deletedTags -Operation Delete
}