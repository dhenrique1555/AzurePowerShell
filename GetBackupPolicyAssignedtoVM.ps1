#Variables
$vaultname = read-host "Insert Vault Name"
$txtpath = read-host "Insert txt PATH containing VM Names"

$vault = get-AzrecoveryServicesVault -Name $vaultname
#Vault Context
Set-AzRecoveryServicesVaultContext -Vault $vault

$result = @()
foreach($vm in get-content $txtpath){
##FriendlyName is your Azure VM name
$namedContainer=Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -friendlyname $vm

$item = Get-AzRecoveryServicesBackupItem -Container $namedContainer -WorkloadType "AzureVM"
$bkppolicy = $item.ProtectionPolicyName

$Result  += New-Object PSObject -property $([ordered]@{ 
Vault = $vault.name
VM = $vm
BackupPolicy = $bkppolicy
})
}

 Get-AzRecoveryServicesBackupProtectionPolicy -WorkloadType AzureVM | fl  name,schedulepolicy,retentionpolicy,snapshotretentionindays