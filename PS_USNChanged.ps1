$RootDSE = [ADSI]"LDAP://RootDSE"
$Domain = [ADSI]""
$Configuration = [adsi]"LDAP://$($RootDSE.configurationNamingContext)"
$Schema = [adsi]"LDAP://$($RootDSE.schemaNamingContext)"
$DomainDNS = [adsi]"LDAP://$($RootDSE.namingContexts |
Where-Object  { $_ -match 'DomainDnsZones' })"
$ForestDNS = [adsi]"LDAP://$($RootDSE.namingContexts |
Where-Object  { $_ -match 'ForestDnsZones' })"

$highestCommittedUSN = $RootDSE.highestCommittedUSN |
ForEach-Object {$_}

$DomainUSNChanged = `
$Domain.ConvertLargeIntegerToInt64($Domain.UsnChanged[0]) -as [int]

$ConfigurationUSNChanged = `
$Configuration.ConvertLargeIntegerToInt64($Configuration.UsnChanged[0]) -as [int]

$SchemaUSNChanged = `
$Schema.ConvertLargeIntegerToInt64($Schema.UsnChanged[0]) -as [int]

$DomainDNSZonesUSNChanged = `
$DomainDNS.ConvertLargeIntegerToInt64($DomainDNS.UsnChanged[0]) -as [int]

$ForestDNSZonesUSNChanged = `
$ForestDNS.ConvertLargeIntegerToInt64($ForestDNS.UsnChanged[0]) -as [int]

[pscustomobject][ordered]@{

highestCommittedUSN = $highestCommittedUSN
DomainUSNChanged  = $DomainUSNChanged
ConfigurationUSNChanged    = $ConfigurationUSNChanged
SchemaUSNChanged = $SchemaUSNChanged
DomainDNSZonesUSNChanged = $DomainDNSZonesUSNChanged
ForestDNSZonesUSNChanged = $ForestDNSZonesUSNChanged
'Total Combined USNChanged'  = $DomainUSNChanged + $ConfigurationUSNChanged + `
$SchemaUSNChanged + $DomainDNSZonesUSNChanged + $ForestDNSZonesUSNChanged

}
