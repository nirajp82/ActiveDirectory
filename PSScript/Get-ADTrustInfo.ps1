# Ensure the Active Directory module is loaded	
Import-Module ActiveDirectory	

# Get the current domain	
$currentDomain = (Get-ADDomain).DistinguishedName	

# Get the forest information	
$forest = Get-ADForest	

# Display forest and current domain	
Write-Host "Current Domain: $currentDomain"	
Write-Host "Forest Name: $($forest.Name)"	
Write-Host "Trust Relationships:"	

# Get trust relationships	
$trusts = Get-ADTrust -Filter *	

# Loop through each trust and display its details	
foreach ($trust in $trusts) {	
    Write-Host "---------------------------------------"	
    Write-Host "Trust Name: $($trust.Name)"	
    Write-Host "Trust Type: $($trust.TrustType)"	

    # Attempt to access more detailed trust properties	
    $trustDetails = Get-ADTrust -Identity $trust.Name -Properties *	

    # Check each property and display	
    Write-Host "Trust Direction: $($trustDetails.TrustDirection -or 'N/A')"	
    Write-Host "Trusted Domain: $($trustDetails.TrustedDomain -or 'N/A')"	
    Write-Host "Is Transitive: $($trustDetails.IsTransitive -or 'N/A')"	
    Write-Host "Trust SID: $($trustDetails.TrustSid -or 'N/A')"	
    Write-Host "Trust Partner: $($trustDetails.TrustPartner -or 'N/A')"	
    Write-Host "Trust Attributes: $($trustDetails.TrustAttributes)"	
    Write-Host "---------------------------------------"	
}	

# Check if there are no trusts	
if (-not $trusts) {	
    Write-Host "No trust relationships found."	
}	
