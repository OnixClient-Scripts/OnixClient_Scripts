
#close vscode
Stop-Process -Force -Name "Code" -ErrorAction SilentlyContinue
Stop-Process -Force -Name "VSCodium" -ErrorAction SilentlyContinue

#make sure it is installed / we have the code command
$hasCodeCommand = (Get-Command -Name "code" -ErrorAction SilentlyContinue) -eq $null
$hasCodiumCommand = (Get-Command -Name "codium" -ErrorAction SilentlyContinue) -eq $null
if ($hasCodeCommand == $false -and $hasCodiumCommand == $false) {
    Write-Host "It seems like you do not have Visual Studio Code installed, a link to it has been opened." -ForegroundColor Red
    Start-Process "https://code.visualstudio.com/download"
    Pause
    Exit
}

#cleanup window
Clear-Host
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host
Write-Host

#
$roamingStatePath = "$($env:LOCALAPPDATA)\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe"
if (!(Test-Path -Path $roamingStatePath -PathType Container))  {
    Write-Host "Minecraft data folder not found!" -ForegroundColor Red
    Pause
    Exit
}
$roamingStatePath = "$($roamingStatePath)\RoamingState"

#create onix client folders if they does not exist
$onixClientFolder = "$($roamingStatePath)\OnixClient"
if (!(Test-Path -Path $onixClientFolder -PathType Container)) {
   New-Item -ItemType Directory -path $onixClientFolder | Out-Null
}

#create scripts folder
$onixClientScriptsFolder = "$($onixClientFolder)\Scripts"
if (!(Test-Path -Path $onixClientScriptsFolder -PathType Container)) {
   New-Item -ItemType Directory -path $onixClientScriptsFolder | Out-Null
}
#create scripts folder
$onixClientScriptsVscodeFolder = "$($onixClientFolder)\Scripts\.vscode"
if (!(Test-Path -Path $onixClientScriptsVscodeFolder -PathType Container)) {
   New-Item -ItemType Directory -path $onixClientScriptsVscodeFolder | Out-Null
}


#create scripts folder
$onixClientScriptsTempFolder = "$($onixClientScriptsFolder)\Temp"
if (!(Test-Path -Path $onixClientScriptsTempFolder -PathType Container)) {
   New-Item -ItemType Directory -path $onixClientScriptsTempFolder | Out-Null
}
if (!(Test-Path -Path "$($onixClientScriptsFolder)\Modules" -PathType Container)) {
   New-Item -ItemType Directory -path "$($onixClientScriptsFolder)\Modules" | Out-Null
}
if (!(Test-Path -Path "$($onixClientScriptsFolder)\Commands" -PathType Container)) {
   New-Item -ItemType Directory -path "$($onixClientScriptsFolder)\Commands" | Out-Null
}
if (!(Test-Path -Path "$($onixClientScriptsFolder)\Libs" -PathType Container)) {
   New-Item -ItemType Directory -path "$($onixClientScriptsFolder)\Libs" | Out-Null
}
if (!(Test-Path -Path $onixClientScriptsTempFolder -PathType Container)) {
    Write-Host "Cannot seem create the RoamingState or OnixClient or Scripts or Scripts/Temp Folder(s)" -ForegroundColor Red
    Pause    
    Exit
 }
Write-Host "Onix Folders Created/Found" -ForegroundColor Green
Write-Host

try {
    Write-Host "Downloading the AutoComplete..."
    Invoke-WebRequest -Uri "https://codeload.github.com/OnixClient-Scripts/OnixClient_Scripts/zip/refs/heads/master" -OutFile "$($onixClientScriptsTempFolder)\Repos.zip" -TimeoutSec 5 -MaximumRedirection 5
    Expand-Archive -Path "$($onixClientScriptsTempFolder)\Repos.zip" -DestinationPath $onixClientScriptsTempFolder
    #move autocomplete
   try {
        Remove-Item -Path "$($onixClientScriptsFolder)\AutoComplete" -Recurse  -ErrorAction SilentlyContinue
   } catch {}
    Move-Item -Path "$($onixClientScriptsTempFolder)\OnixClient_Scripts-master\AutoComplete" -Destination "$($onixClientScriptsFolder)\AutoComplete" -Force -ErrorAction SilentlyContinue
    Write-Host "AutoComplete has been successfully downloaded!" -ForegroundColor Green
}
catch {
    Write-Host "Could not download the AutoComplete" -ForegroundColor Red
    Pause    
    Exit
}

#delete temp folder
try {
    Remove-Item -Path $onixClientScriptsTempFolder -Recurse -ErrorAction SilentlyContinue
} catch {}

Write-Host
#install vscode extensions
$extensions =
    "sumneko.lua"

if ($hasCodeCommand -eq $false) {
    Invoke-Expression "code --list-extensions" -OutVariable output | Out-Null
    $installed = $output -split "\s"

    
    Write-Host "Installing Visual Studio Code extensions..."
    foreach ($extension in $extensions) {
        if ($installed.Contains($extension)) {
            Write-Host "  - "$extension " is already installed." -ForegroundColor Gray
        } else {
            Write-Host "  - Installing" $extension "..." -ForegroundColor White
            code --install-extension $extension | Out-Null
        }
    }
    Write-Host "Visual Studio Code extensions have been installed" -ForegroundColor Green
    Write-Host
}
if ($hasCodiumCommand -eq $false) {
    Invoke-Expression "codium --list-extensions" -OutVariable output | Out-Null
    $installed = $output -split "\s"

    Write-Host "Installing VSCodium extensions..."
    foreach ($extension in $extensions) {
        if ($installed.Contains($extension)) {
            Write-Host "  - "$extension " is already installed." -ForegroundColor Gray
        } else {
            Write-Host "  - Installing" $extension "..." -ForegroundColor White
            codium --install-extension $extension | Out-Null
        }
    }
    Write-Host "VSCodium extensions have been installed" -ForegroundColor Green
    Write-Host
}




#configure vscode extensions
Write-Host "Configuring Extensions..."
$settingsJsonPath = "$($onixClientScriptsVscodeFolder)\settings.json"
try {
    $settings = (Get-Content -Path $settingsJsonPath -ErrorAction SilentlyContinue) | ConvertFrom-Json
    if ($settings -eq $null) { #when file is empty
        $settings = "{}" | ConvertFrom-Json
    }
    Add-Member -InputObject $settings -Name "Lua.workspace.library" -Value @( "$($onixClientScriptsFolder)\AutoComplete" ) -MemberType NoteProperty -Force
    Add-Member -InputObject $settings -Name "Lua.diagnostics.disable" -Value @( "lowercase-global" ) -MemberType NoteProperty -Force
    $settings = ($settings | ConvertTo-Json)
    Out-File -FilePath $settingsJsonPath -Encoding ascii -InputObject "$($settings)"
    Write-Host "Extensions have been configured" -ForegroundColor Green
} catch {
    Write-Host "Could not set the autocomplete directory" -ForegroundColor Red
    Pause
    Exit
}
Write-Host

if ($hasCodiumCommand -eq $false) {
    Write-Host "Opening VSCodium in the Scripts workspace"
    Start-Process -FilePath "codium" -ArgumentList $onixClientScriptsFolder -WindowStyle Hidden
} else {
    Write-Host "Opening Visual Studio Code in the Scripts workspace"
    Start-Process -FilePath "code" -ArgumentList $onixClientScriptsFolder -WindowStyle Hidden
}


