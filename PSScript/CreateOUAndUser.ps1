# Define the names of the OUs
#$ouNames = @("OU1", "OU2", "OU3", "OU4", "OU5")
$ouNames = @("NorthAmerica", "Asia", "SouthAmerica", "Europe", "Africa")


# Loop through the OU names and create each OU
foreach ($ouName in $ouNames) {
    New-ADOrganizationalUnit -Name $ouName -Path "OU=MyCompany,DC=example,DC=com"
}

# Define an array of first names and last names
$firstNames = @("John", "Jane", "Mike", "Emily", "David", "Sarah", "Kevin", "Rachel", "Mark", "Linda")
$lastNames = @("Smith", "Johnson", "Garcia", "Brown", "Davis", "Miller", "Jones", "Wilson", "Moore", "Taylor")

# Loop through the OUs and create 25 users in each OU
foreach ($ouName in $ouNames) {
    for ($i = 1; $i -le 25; $i++) {
        # Generate a random first name and last name
        $firstName = $firstNames | Get-Random
        $lastName = $lastNames | Get-Random

        # Combine the first name and last name to create the user's full name
        $fullName = "$firstName $lastName"

        # Generate a random password for the user
        $password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})

        # Create the user in the given OU with the given full name and password
        New-ADUser -Name $fullName -GivenName $firstName -Surname $lastName -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path "OU=$ouName,OU=MyCompany,DC=example,DC=com"
    }
}

# Create some groups
New-ADGroup -Name "AllADUser" -GroupCategory Security -GroupScope Global -Path "OU=MyCompany,DC=example,DC=com"
New-ADGroup -Name "Sales" -GroupCategory Security -GroupScope Global -Path "OU=MyCompany,DC=example,DC=com"
New-ADGroup -Name "Marketing" -GroupCategory Security -GroupScope Global -Path "OU=MyCompany,DC=example,DC=com"
New-ADGroup -Name "Support" -GroupCategory Security -GroupScope Global -Path "OU=MyCompany,DC=example,DC=com"
New-ADGroup -Name "IT" -GroupCategory Security -GroupScope Global -Path "OU=MyCompany,DC=example,DC=com"


# Add the users from each OU to Group1
foreach ($ouName in $ouNames) {
    $users = Get-ADUser -Filter {Enabled -eq $true} -SearchBase "OU=$ouName,OU=MyCompany,DC=example,DC=com"
    Add-ADGroupMember -Identity "Group1" -Members $users
}

# Add the first 10 users from each OU to Group2
foreach ($ouName in $ouNames) {
    $users = Get-ADUser -Filter {Enabled -eq $true} -SearchBase "OU=$ouName,OU=MyCompany,DC=example,DC=com" | Select-Object -First 10
    Add-ADGroupMember -Identity "Group2" -Members $users
}
