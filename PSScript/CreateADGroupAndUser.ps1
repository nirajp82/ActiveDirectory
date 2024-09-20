# Define the names of the groups	
$groupNames = @("Group1", "Group2", "Group3", "Group4", "Group5")	

# Define the names of the users	
$userNames = @("User1", "User2", "User3", "User4", "User5")	

# Create the groups	
foreach ($groupName in $groupNames) {	
    New-ADGroup -Name $groupName -GroupCategory Security -GroupScope Global	
}	

 $password = "testTEST1234"	
# Add users to the groups	
foreach ($groupName in $groupNames) {	
    $group = Get-ADGroup -Filter { Name -eq $groupName }	
    foreach ($userName in $userNames) {	
    $firstName = $userName 	
    $lastName = "" 	
     # Combine the first name and last name to create the user's full name	
    $fullName = "$firstName $lastName"	

           # Create the user with the given full name and password	
    New-ADUser -Name $fullName -GivenName $firstName -Surname $lastName -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true	
        $user = Get-ADUser -Filter { Name -eq $userName }	
        Add-ADGroupMember -Identity $group -Members $user	
    }	
}
