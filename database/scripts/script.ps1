param (
    [Parameter(Mandatory=$true)]$server,
    [Parameter(Mandatory=$true)]$username    
)

$password = Read-Host "Azure SQL Password" -asSecureString

$sqlPackage="C:\SqlPackage\sqlpackage.exe"
$dacpac="../dacpac/bus-db.dacpac"

$PwdPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
$PlainTextPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto($PwdPointer)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($PwdPointer)

Invoke-Expression "$sqlPackage /a:script /op:script.sync.sql /sf:$dacpac /tcs:""Data Source=$server.database.windows.net;Initial Catalog=bus-db;UID=$username;PWD=$PlainTextPassword"""