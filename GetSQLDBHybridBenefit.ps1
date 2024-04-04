$azSubs = Get-AzSubscription
$databases  = @()
$output = @()
foreach ( $azSub in $azSubs ){
Set-AzContext -Subscription $azSub | Out-Null
$azSubName = $azSub.Name
$databases += Get-AzResource -ResourceType "Microsoft.Sql/servers" |ForEach-Object -Process {Get-AzSqlDatabase -ServerName $_.Name -ResourceGroupName $_.ResourceGroupName}
foreach ($database in $databases) {
$props = @{
Servername = $database.ServerName
Databasename = $database.DatabaseName
Region = $database.Location
LicenseType = $database.LicenseType
CreationDate = $database.CreationDate
ResourceGroupName = $database.ResourceGroupName
Subscription = $azsubname
 
}
$ServiceObject = New-Object -TypeName PSObject -Property $props
$output += $serviceobject
}
$databases|Where-Object -Property LicenseType -eq "BasePrice"|Select ResourceGroupName,ServerName,DatabaseName | Export-csv c:\temp\SQLHybrid.csv -notypeinformation
