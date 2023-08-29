# Define an array of first names and last names
$firstNames = @("John", "Jane", "Mike", "Emily", "David", "Sarah", "Kevin", "Rachel", "Mark", "Linda")
$lastNames = @("Smith", "Johnson", "Garcia", "Brown", "Davis", "Miller", "Jones", "Wilson", "Moore", "Taylor")

# Loop 50 times to create 50 users
for ($i = 1; $i -le 50; $i++) {
    # Generate a random first name and last name
    $firstName = $firstNames | Get-Random
    $lastName = $lastNames | Get-Random

    # Combine the first name and last name to create the user's full name
    $fullName = "$firstName $lastName"

    # Generate a random password for the user
    $password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})

    # Create the user with the given full name and password
    New-ADUser -Name $fullName -GivenName $firstName -Surname $lastName -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true
}

###############
Import-Module ActiveDirectory

# Set the common password for all users
$password = ConvertTo-SecureString -String "PasswordGoesHere" -AsPlainText -Force

# Specify the Organizational Unit (OU) path
$ouPath = "OU=Users,DC=yourdomain,DC=com"

# Specify the UPN suffix
$upnSuffix = "yourdomain.com"

# Create 5 users
for ($i = 1; $i -le 5; $i++) {
    $givenName = "User$i"
    $surName = "LastName$i"
    $displayName = "User LastName $i"
    $samAccountName = "user$i"
    $emailAddress = "user$i@$upnSuffix"
    $userPrincipalName = "user$i@$upnSuffix"

    New-ADUser -Name $displayName -GivenName $givenName -Surname $surName -DisplayName $displayName -SamAccountName $samAccountName -EmailAddress $emailAddress -UserPrincipalName $userPrincipalName -AccountPassword $password -Path $ouPath -Enabled $true
}
