To create local admin account.

# The default password for the new accounts
$password = ConvertTo-SecureString "" -AsPlainText -Force

# Group new users are added to (default is Users)
$group = "Administrators"

# PowerShell array containing the users to be created
$users = @(
	# List users here to be created
	""
)

# Creates a new users for each entry in the $users array
foreach ($user in $users) {
	
	# Create and add user to Users group
	New-LocalUser -Name "$user" -Password $Password
	Add-LocalGroupMember -Group "$group" -Member "$user"
	
	# Set users password to be changed at next logon
	$expUser = [ADSI]"WinNT://localhost/$user,user"
	$expUser.passwordExpired = 0
	$expUser.setinfo()
	
	}
Set-LocalUser -Name "" -PasswordNeverExpires 1