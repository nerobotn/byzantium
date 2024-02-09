# Prompt the user to input the NAS server name
$serverName = Read-Host "Enter the NAS server name"

# Construct the root path of the NAS
$rootPath = "\\$serverName\"

# Function to recursively check permissions for folders
function CheckFolderPermissions($folderPath) {
    # Get the ACL for the folder
    $folderACL = Get-Acl -Path $folderPath

    # Check permissions for each access rule in the ACL
    foreach ($accessRule in $folderACL.Access) {
        $identity = $accessRule.IdentityReference.Value
        $permissions = $accessRule.FileSystemRights

        Write-Host "Folder: $($folderPath.Replace($rootPath, '')) - Identity: $identity - Permissions: $permissions"
    }

    # Recursively check permissions for subfolders
    $subfolders = Get-ChildItem -Path $folderPath -Directory
    foreach ($subfolder in $subfolders) {
        CheckFolderPermissions $subfolder.FullName
    }
}

# Check permissions for each folder in the root directory
$rootFolders = Get-ChildItem -Path $rootPath -Directory
foreach ($folder in $rootFolders) {
    CheckFolderPermissions $folder.FullName
}

