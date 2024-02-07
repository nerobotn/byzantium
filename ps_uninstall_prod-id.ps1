# Define the Product ID of the application you want to uninstall
$prodID = "YOUR_PRODUCT_ID_HERE"

# Get the list of installed products matching the specified Product ID
$installedApps = Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -eq $prodID }

if ($installedApps) {
    # Uninstall each matching product
    foreach ($app in $installedApps) {
        Write-Host "Uninstalling $($app.Name) (Product ID: $($app.IdentifyingNumber))"
        $uninstallResult = $app.Uninstall()

        # Check the result of the uninstallation
        if ($uninstallResult -eq 0) {
            Write-Host "Uninstallation of $($app.Name) completed successfully."
        } else {
            Write-Host "Failed to uninstall $($app.Name). Error code: $uninstallResult"
        }
    }
} else {
    Write-Host "No application found with Product ID: $prodID"
}

