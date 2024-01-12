# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing the list of users (one username per line)
$userListFilePath = "C:\Path\To\Your\UserList.txt"

# Check if the user list file exists
if (Test-Path $userListFilePath) {
    # Read the list of users from the text file
    $userList = Get-Content $userListFilePath

    # Iterate through each user
    foreach ($user in $userList) {
        # Get the user object from AD
        $adUser = Get-ADUser -Filter {SamAccountName -eq $user} -Properties "DisplayName", "PwdLastSet", "msDS-UserPasswordExpiryTimeComputed"

        if ($adUser) {
            # Check if the password needs to be changed
            $changePasswordOnNextLogon = ($adUser.PwdLastSet -eq 0) -or ($adUser."msDS-UserPasswordExpiryTimeComputed" -eq 0)

            Write-Host "User: $($adUser.DisplayName)"
            Write-Host "Change Password on Next Logon: $changePasswordOnNextLogon`n"
        } else {
            Write-Host "User '$user' not found in Active Directory.`n"
        }
    }
} else {
    Write-Host "User list file not found: $userListFilePath"
}