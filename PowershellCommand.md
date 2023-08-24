* `Install-WindowsFeature RSAT-AD-PowerShell`: To install  "Remote Server Administration Tools for active directory". It refers to the Active Directory PowerShell module, which provides PowerShell cmdlets for managing and interacting with Active Directory services.
* `$domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()`: To get an instance of the current domain, and you can then access properties of the returned domain object to get information like the domain's name, domain controllers, etc.
* `[System.DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite()`: to get an instance of the site where the computer resides. You can access properties of the returned site object to get information about the site's name, description, subnets, etc.
  
* ## Useful Active Directory PowerShell Cmdlets

### Getting Information

- `Get-ADUser`: Retrieve user account information.
- `Get-ADComputer`: Retrieve computer account information.
- `Get-ADGroup`: Retrieve group information.
- `Get-ADOrganizationalUnit`: Retrieve organizational unit information.
- `Get-ADDomain`: Retrieve domain information.
- `Get-ADDomainController`: Retrieve domain controller information.

### Creating Objects

- `New-ADUser`: Create a new user account.
- `New-ADComputer`: Create a new computer account.
- `New-ADGroup`: Create a new group.
- `New-ADOrganizationalUnit`: Create a new organizational unit.

### Modifying Objects

- `Set-ADUser`: Modify user account properties.
- `Set-ADComputer`: Modify computer account properties.
- `Set-ADGroup`: Modify group properties.
- `Move-ADObject`: Move an object to a different organizational unit.
- `Rename-ADObject`: Rename an Active Directory object.

### Removing Objects

- `Remove-ADUser`: Remove a user account.
- `Remove-ADComputer`: Remove a computer account.
- `Remove-ADGroup`: Remove a group.
- `Remove-ADOrganizationalUnit`: Remove an organizational unit.

### Managing Group Membership

- `Add-ADGroupMember`: Add a member to a group.
- `Remove-ADGroupMember`: Remove a member from a group.

### Managing Permissions

- `Set-ADACL`: Set permissions for an Active Directory object.
- `Get-ADPermission`: Retrieve permissions for an Active Directory object.

### Managing Passwords

- `Set-ADAccountPassword`: Set a user account's password.
- `Unlock-ADAccount`: Unlock a locked user account.

### Searching

- `Get-ADObject`: Retrieve any Active Directory object based on specified filters.
- `Get-ADPrincipalGroupMembership`: Retrieve groups a user is a member of.
