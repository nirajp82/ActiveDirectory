# Define the names of the groups
$groupNames = @("Group1", "Group2", "Group3", "Group4", "Group5")

# Define the names of the users
$userNames = @("User1", "User2", "User3", "User4", "User5")

# Create the groups
foreach ($groupName in $groupNames) {
    New-ADGroup -Name $groupName -GroupCategory Security -GroupScope Global
}

# Add users to the groups
foreach ($groupName in $groupNames) {
    $group = Get-ADGroup -Filter { Name -eq $groupName }
    foreach ($userName in $userNames) {
        $user = Get-ADUser -Filter { Name -eq $userName }
        Add-ADGroupMember -Identity $group -Members $user
    }
}
