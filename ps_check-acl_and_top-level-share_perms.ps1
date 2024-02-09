# Define the computer name and top-level share name
$computerName = "ServerName"
$shareName = "C$"  # Replace "C$" with the appropriate top-level share name

# Get the list of shared folders and their permissions
$sharePath = "\\$computerName\$shareName"
$shareACL = Get-Acl -Path $sharePath

# Check if the current user has any permissions on the shared folder(s)
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$accessRules = $shareACL.GetAccessRules($true, $true, [System.Security.Principal.NTAccount])

$hasAccess = $false
foreach ($rule in $accessRules) {
    if ($rule.IdentityReference -eq $user) {
        $hasAccess = $true
        break
    }
}

# Output the result
if ($hasAccess) {
    Write-Host "You have access to folders in the top-level share: $sharePath"
} else {
    Write-Host "You do not have access to any folders in the top-level share: $sharePath"
}
