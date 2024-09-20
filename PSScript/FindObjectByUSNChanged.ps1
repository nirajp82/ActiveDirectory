# Define the USNChanged value you want to search for
$usnChangedValue = 12345  # Replace with the actual USNChanged value you're looking for

# Specify the distinguished name (DN) of the base directory where you want to search
$searchBase = "DC=example,DC=com"  # Replace with the appropriate base DN for your environment

# Use the Get-ADObject cmdlet to retrieve the AD object by its USNChanged value
$adObject = Get-ADObject -server "MyDCServerName.com" -Filter {usnChanged -eq $usnChangedValue} -SearchBase $searchBase

# Check if an object was found
if ($adObject -ne $null) {
    Write-Host "AD Object found:"
    Write-Host "DN: $($adObject.DistinguishedName)"
    Write-Host "Name: $($adObject.Name)"
    # Add more properties as needed
} else {
    Write-Host "No AD object found with USNChanged value $usnChangedValue."
}
