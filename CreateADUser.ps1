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
