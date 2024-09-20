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

# Specify the domain controller path
$dcPath = "DC=yourdomain,DC=com"
# Specify the UPN suffix
$upnSuffix = "yourdomain.com"
#Name of the OU
$ouName = "MyPSOU"
# Specify the Organizational Unit (OU) path
$ouPath = "OU=$ouName,$dcPath"
$maxUserCnt = 50
# Check if the OU exists, create it if not
if (-not (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $ouPath})) {
    New-ADOrganizationalUnit -Name $ouName -Path $dcPath
}

$groups = @("Group1", "Group2", "Group3", "Group4", "Group5", "GroupAll")# Array of group names

Write-Host "Create users. Count: $maxUserCnt"
# Create users
for ($cnt = 1; $cnt -le $maxUserCnt; $cnt++) {
    $givenName = "UserPS$cnt"
    $surName = "LastName$cnt"
    $displayName = "UserPS LastName$cnt"
    $samAccountName = "userPS$cnt"
    $emailAddress = "userPS$cnt@$upnSuffix"
    $userPrincipalName = "userPS$cnt@$upnSuffix"
	
	# Check if the user exists, remove it if it does
    $existingUser = Get-ADUser -Filter {SamAccountName -eq $samAccountName}
    if ($existingUser) {
        Remove-ADUser -Identity $existingUser -Confirm:$false
    }

    $newUser = New-ADUser -Name $displayName -GivenName $givenName -Surname $surName -DisplayName $displayName -SamAccountName $samAccountName -EmailAddress $emailAddress -UserPrincipalName $userPrincipalName -AccountPassword $password -Enabled $true -Path $ouPath -PassThru
	
	$mgrId = 1
	if($cnt -ge 10)
	{
		$mgrId = $cnt - 10
	}	
	$managerSamAccountName =  "userPS$mgrId";
	
	# Get the manager's DistinguishedName
	$managerDN = Get-ADUser -Filter {SamAccountName -eq $managerSamAccountName} | Select-Object -ExpandProperty DistinguishedName

	# Set the manager for the new user
	Set-ADUser -Identity $samAccountName -Manager $managerDN	
}

Write-Host "Users are created, Adding users to the group."

$cnt = 1
foreach ($groupToAddUser in $groups) {
	# Check if the group exists, create it if not
	if (-not (Get-ADGroup -Filter {Name -eq $groupToAddUser})) {
		Write-Host "Creating group: $groupToAddUser."
		New-ADGroup -Name $groupToAddUser -GroupScope Global -Path $ouPath -Description "Dummy PS group - $groupToAddUser"
	}
	
	if($groupToAddUser -eq "GroupAll") {
		$startIndex = 0
		$pageSize = $maxUserCnt+1
	}
	else {
		$pageSize = $maxUserCnt/$groups.Count
		$startIndex = ($cnt - 1) * $pageSize
	}

	$users = Get-ADUser -Filter {Enabled -eq $true} -SearchBase $ouPath | Select-Object -Skip $startIndex -First $pageSize

	Add-ADGroupMember -Identity $groupToAddUser -Members $users
	$cnt++
}

Write-Host "Done."
