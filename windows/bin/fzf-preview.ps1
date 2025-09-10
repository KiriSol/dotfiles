param(
    [string]$Path
)

if (-not (Test-Path -Path $Path)) {
    Write-Host "❌ This path is not valid: $Path"
    exit 1
}

function Get-MimeType {
    param($FileName)
    if (Get-Command -Name file.exe -ErrorAction SilentlyContinue) {
        return "$(file.exe --brief --dereference --mime-type -- $FileName)"
    }
    if ($(Get-Item -Path $FileName).PSIsContainer) {
        return 'inode/directory'
    }
    try {
        # Cache DB for best performance
        if (-not $global:MimeDbCache) {
            $Global:MimeDbCache = Invoke-RestMethod -Uri "https://cdn.jsdelivr.net/gh/jshttp/mime-db@master/db.json"
        }
        $MediaTypes = $Global:MimeDbCache.psobject.Properties
        $MatchingMediaType = $mediaTypes.Where(
            { $_.Value.extensions -contains [IO.Path]::GetExtension($FileName).Substring(1) },
            'First'
        ).Name
        # Use a fallback type, if no match was found.
        if (-not $MatchingMediaType) { $MatchingMediaType = 'application/octet-stream' }

        return $MatchingMediaType
    }
    catch {
        # Fallback
        $ext = [System.IO.Path]::GetExtension($File).ToLower()
        switch ($ext) {
            '.txt' { return 'text/plain' }
            '.md' { return 'text/markdown' }
            '.json' { return 'application/json' }
            '.xml' { return 'application/xml' }
            '.ps1' { return 'text/x-powershell' }
            '.cmd' { return 'text/x-msdos-batch' }
            '.c' { return 'text/x-c' }
            '.cpp' { return 'text/x-cpp' }
            '.py' { return 'text/plain' }
            '.js' { return 'text/plain' }
            '.jpg' { return 'image/jpeg' }
            '.jpeg' { return 'image/jpeg' }
            '.png' { return 'image/png' }
            '.gif' { return 'image/gif' }
            '.mp4' { return 'video/mp4' }
            '.avi' { return 'video/x-msvideo' }
            '.zip' { return 'application/zip' }
            '.7z' { return 'application/x-7z-compressed' }
            default { return 'application/octet-stream' }
        }
    }
}


try {
    $item = Get-Item -Path $Path -ErrorAction Stop
}
catch {
    Write-Host "Permission denied: $Path"
    exit 1
}

if ($item.PSIsContainer) {
    Write-Host "📁 '$($item.Name)' directory content:"
    if (Get-Command -Name eza.exe -ErrorAction SilentlyContinue) {
        eza.exe --icons=always --color=always --header --long --no-time --no-permissions -- $Path
    }
    else {
        Get-ChildItem -Path $Path -Force | Format-Table -AutoSize Name, Length, LastWriteTime
    }
    exit 0
}

$mimeType = Get-MimeType $Path

if ($mimeType -eq 'inode/directory') {
    Write-Host "📁 '$($item.Name)' directory content:"
    if (Get-Command -Name eza.exe -ErrorAction SilentlyContinue) {
        eza.exe --icons=always --color=always --header --long --no-time --no-permissions -- $Path
    }
    else {
        Get-ChildItem -Path $Path -Force | Format-Table -AutoSize Name, Length, LastWriteTime
    }
    exit 0
}

if ($Host.UI.RawUI.WindowSize.Height -gt 10) {
    Write-Host "📊 Information:"
    Write-Host "    Name: '$($item.Name)'"
    Write-Host "    Size: $([math]::Round($item.Length/1KB, 2)) KB"
    Write-Host "    MIME-type: $mimeType"
    Write-Host "🎯 Content:"
}

if ($mimeType -eq 'inode/x-empty') {
    Write-Host "Empty file"
}
elseif ($mimeType -like 'text/*' -or $mimeType -like 'application/json*' -or $mimeType -like 'application/xml*') {
    if (Get-Command -Name bat.exe -ErrorAction SilentlyContinue) {
        bat.exe --style=numbers --color=always --pager=never --highlight-line=0 -- "$Path"
    }
    else {
        Get-Content -Path $Path -TotalCount 50 | ForEach-Object {
            $line = $_
            if ($line.Length -gt 120) {
                $line.Substring(0, 117) + "..."
            }
            else {
                $line
            }
        }
    }
}
elseif ($mimeType -like 'image/*' -or $mimeType -like 'video/*') {
    if (Get-Command -Name chafa.exe -ErrorAction SilentlyContinue) {
        chafa.exe --size=$(
            if ($Host.UI.RawUI.WindowSize.Width)
                { $Host.UI.RawUI.WindowSize.Width - 3 }
            else
                { 60 }
        ) "$Path"
    }
    else {
        Write-Host "🖼️ Media-file, please install chafa"
        if (Get-Command -Name file.exe -SilentlyContinue) { file.exe $Path }
    }
}
elseif ($mimeType -like 'application/*zip*' -or $mimeType -like 'application/*rar*') {
    if (Get-Command -Name 7z.exe -ErrorAction SilentlyContinue) {
        Write-Host "📦 Archive content:"
        7z.exe l "$Path" | Select-Object -First 50
    }
    else {
        Write-Host "📦 Archive, please install 7zip"
    }
}
else {
    if (Get-Command -Name file.exe -ErrorAction SilentlyContinue) {
        file.exe $Path
    }
    Write-Host "🔢 HEX:"
    if (Get-Command -Name strings.exe -ErrorAction SilentlyContinue) {
        strings $Path | Select-Object -First 50
    }
    else {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $hex = [System.BitConverter]::ToString($bytes[0..15]) -replace '-', ' '
        Write-Host "$hex"
    }
}
