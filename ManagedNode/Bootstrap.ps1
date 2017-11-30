# Setup Administrator user and password
$username = "Administrator"
$password = "password"
if (Get-WmiObject Win32_UserAccount -Filter "LocalAccount='true' and Name='Administrator'") {
  net user $username $password
  wmic useraccount where "Name='$username'" set disabled=false
} else {
  net user $username $password /add
  net localgroup Administrators $username /add
}
wmic useraccount where "Name='$username'" set PasswordExpires=false


# Install chocolatey
$chocoPath = $env:chocolateyinstall
if ($chocoPath -eq $null -or $chocoPath -eq '' -or !(Test-Path($chocoPath))) {
  Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install .NET 4.6.2
if (!(Get-ChildItem "hklm:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Get-ItemProperty -Name Release | % { $_.Release -ge 394802 })) {
  cinst -y dotnet-4.6.2
  $changed = $True
}

# Install powershell 4
if ($PSVersionTable.PSVersion.Major -lt 4) {
  cinst -y powershell4
  $changed = $True
}

# Reboot
if ($changed) {
  Restart-Computer -Force
}
