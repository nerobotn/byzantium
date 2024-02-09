# Prompt the user to input the computer name
$computerName = Read-Host "Enter the computer name"

# Prompt the user to input the share name
$shareName = Read-Host "Enter the share name (e.g., C$)"

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

