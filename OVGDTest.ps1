# Global Dashboard scripts

[string]$OVGDName     = "10.10.104.6"
[string]$OVGDUser     = "Administrator"
[string]$OVGDPass     = "HP1nvent"
[string]$OVGDDomain   = "local"


write-host -ForegroundColor Magenta "Connect to OneView appliance:$OVGDName"
if ( !$ConnectedSessions ) {
    $secpasswd = ConvertTo-SecureString $OVGDPass -AsPlainText -Force
    $OVGDCreds = New-Object System.Management.Automation.PSCredential ("$OVGDUser", $secpasswd)
    $MyConnection = Connect-OVGD -Server $OVGDName -Credential $OVGDCreds
} else {
    Write-Host -ForegroundColor Magenta "Already connected to $OVGDName"
}

Get-OVGDAppliance -Server $OVGDName
$Servers = Get-OVGDServerHardware -Server $OVGDName

Write-Host "Server Info" 
foreach ($server in $Servers ) {
    Write-Host $Server.mpDnsName,"profile state:",$Server.state, "and power:",$Server.powerState
}