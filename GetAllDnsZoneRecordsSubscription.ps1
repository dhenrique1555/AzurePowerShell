$result = @()
$subname = read-host "Enter Subscription Name"
$Subscriptions = Get-AzSubscription -subscriptionname $zone
 
foreach($sub in $subscriptions){
$zones = @()
Get-AzSubscription -SubscriptionName $sub.Name | Set-azcontext
$Zones += Get-AzDnsZone
 
foreach($zone in $zones.name){
 
 
$RecordSets = Get-AzDnsRecordSet -ResourceGroupName "rg-dns" -ZoneName $zone
 
foreach($recordset in $recordsets){
#Export Results to Variable
$Result += New-Object PSObject -property $([ordered]@{ 
SubscriptionName = $sub.name
RecordType = $recordset.recordtype
Name = $recordset.name
RG = $recordset.resourcegroupname
Zone = $recordset.zonename
Records = $recordset.records -join ","
})
}
}
}
 
$result
