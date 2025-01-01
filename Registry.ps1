function Load-Registry {
    param (
        [string]$datFilePath,
        [string]$hiveName
    )
    
    if (Test-Path $datFilePath) {
        # Load the registry hive
        reg load $hiveName $datFilePath
        Write-Host "Successfully loaded the registry hive: $hiveName"
    } else {
        Write-Host "The specified file does not exist: $datFilePath"
    }
}


function Unload-Registry {
    param (
        [string]$hiveName
    )
    
    # Unload the registry hive
    reg unload $hiveName
    Write-Host "Successfully unloaded the registry hive: $hiveName"
}


Load-Registry -datFilePath "C:\Path\To\Your\RegistryFile.dat" -hiveName "HKLM\Software\MyHive"
Unload-Registry -hiveName "HKLM\Software\MyHive"





function Replicate-RegistryTree {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    # Check if the source registry path exists
    if (Test-Path "HKCU\$sourcePath" -or Test-Path "HKLM\$sourcePath") {
        # Determine if source is HKCU or HKLM
        $sourceRoot = ""
        if (Test-Path "HKCU\$sourcePath") {
            $sourceRoot = "HKCU"
        } elseif (Test-Path "HKLM\$sourcePath") {
            $sourceRoot = "HKLM"
        }

        # Create a temporary file for the export
        $tempRegFile = [System.IO.Path]::GetTempFileName()
        
        # Export the source registry subtree to a temporary .reg file
        reg export "$sourceRoot\$sourcePath" $tempRegFile /y

        # Import the registry data to the destination path
        reg import $tempRegFile

        # Clean up the temporary .reg file
        Remove-Item $tempRegFile

        Write-Host "Successfully replicated registry tree from $sourceRoot\$sourcePath to $destinationPath"
    } else {
        Write-Host "Source registry path does not exist: $sourcePath"
    }
}
