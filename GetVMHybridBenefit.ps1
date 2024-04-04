$azSubs = Get-AzSubscription
$vms  = @()
$output = @()
foreach ( $azSub in $azSubs ){
Set-AzContext -Subscription $azSub | Out-Null
$azSubName = $azSub.Name
$VMs = Get-azvm 

foreach ($vm in $vms) {
$props = @{
VMname = $vm.Name
VMSize = $vm.hardwareprofile.VmSize
ResourceGroup = $vm.ResourceGroupName
Region = $vm.Location
LicenseType = $vm.LicenseType
OsType = $vm.storageprofile.osdisk.ostype
Publisher = $vm.storageprofile.imagereference.publisher
Offer = $vm.storageprofile.imagereference.Offer
Sku = $vm.storageprofile.imagereference.Sku
CreationDate = $vm.TimeCreated
Subscription = $azsubname
 
}
$ServiceObject = New-Object -TypeName PSObject -Property $props
$output += $serviceobject
}
}
