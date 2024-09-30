$path = Get-Location
Get-ChildItem -Path $path -Directory | ForEach-Object {
    Get-ChildItem -Path $_.FullName -Filter "Telegram.exe" | ForEach-Object {
        Remove-Item $_.FullName -Force
    }
}