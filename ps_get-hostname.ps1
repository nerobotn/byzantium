# Function to get hostname or computer name for an IP address
Function Get-HostName {
    param (
        [string]$IPAddress
    )

    # Use Test-Connection to resolve IP address to hostname or computer name
    $result = Test-Connection -ComputerName $IPAddress -Count 1 -ErrorAction SilentlyContinue

    if ($result) {
        return $result.Address
    } else {
        return "Unknown"
    }
}

# Prompt the user to input the file path containing the list of IPv4 addresses
$filePath = Read-Host -Prompt "Enter the file path containing the list of IPv4 addresses"

# Check if the file exists
if (Test-Path $filePath -PathType Leaf) {
    # Read the file content
    $ipAddresses = Get-Content $filePath

    # Iterate through each IPv4 address and get its hostname or computer name
    foreach ($ipAddress in $ipAddresses) {
        # Get the hostname or computer name for the IPv4 address
        $hostName = Get-HostName -IPAddress $ipAddress

        Write-Host "IPv4 Address: $ipAddress, Hostname or Computer Name: $hostName"
    }
} else {
    Write-Host "File not found: $filePath"
}
