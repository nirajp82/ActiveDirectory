# Creating DirectoryEntry object
$de = New-Object System.DirectoryServices.DirectoryEntry

# Setting LDAP path
$de.Path = "LDAP://MyDC"

# Creating DirectorySearcher object
$search = New-Object System.DirectoryServices.DirectorySearcher($de)

# Setting search filter
$search.Filter = "(&(objectClass=user)(sAMAccountName=JohnDoe))"

# Finding one result
$results = $search.FindOne()

if($results  -ne $null) {
	# Getting DirectoryEntry from the result
	$de = $results.GetDirectoryEntry()
	Write-Host "User Information:"
	Write-Host "------------------"
	Write-Host "Username: $($de.Properties['sAMAccountName'].Value)"
    Write-Host "FirstName: $($de.Properties['givenName'].Value)"    
    Write-Host "LastName: $($de.Properties['sn'].Value)"    
    Write-Host "CN: $($de.Properties['cn'].Value)"    
}
else{
	Write-Host "Not found"
}
# Close the DirectoryEntry object
	$de.Close()	
