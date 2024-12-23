# Variables
$logFile = "C:\Logs\DotNet.Log"
$packageToUninstall = "Microsoft.DotNet.AspNetCore.6"
$packageToInstall = "Microsoft.DotNet.AspNetCore.9"

# Ensure the log directory exists
if (!(Test-Path -Path (Split-Path -Path ${logFile}))) {
    New-Item -ItemType Directory -Path (Split-Path -Path ${logFile}) -Force | Out-Null
}

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[$timestamp] $message"
    $entry | Tee-Object -FilePath ${logFile} -Append
}

# Log the start of the script
Log-Message "Script started."

# Uninstall .NET AspNetCore 6
Log-Message "Attempting to uninstall ${packageToUninstall} silently..."
try {
    winget uninstall ${packageToUninstall} -e --accept-source-agreements --accept-package-agreements --force
    Log-Message "Successfully uninstalled ${packageToUninstall}."
} catch {
    Log-Message "Error uninstalling ${packageToUninstall}: $_"
}

# Install .NET AspNetCore 9
Log-Message "Attempting to install ${packageToInstall} silently..."
try {
    winget install ${packageToInstall} -e --accept-source-agreements --accept-package-agreements --force
    Log-Message "Successfully installed ${packageToInstall}."
} catch {
    Log-Message "Error installing ${packageToInstall}: $_"
}

# Log the end of the script
Log-Message "Script completed."
