param(
    [string]$Path
)

if (-not (Test-Path -Path $Path)) {
    Write-Host "❌ This path is not valid: $Path"
    exit 1
}

try {
    $item = Get-Item -Path $Path -ErrorAction Stop
} catch {
    Write-Host "❌ Permission denied: $Path"
    exit 1
}

if ($item.PSIsContainer) {
    Write-Host "📁 Directory:"
    if (Get-Command -Name eza -ErrorAction Ignore) {
        eza --icons=always --color=always --header --long --no-time --no-permissions -- $Path
    } else {
        Get-ChildItem -Path $Path -Force | Format-Table -AutoSize Name, Length, LastWriteTime
    }
    exit 0
}

if (Get-Command -Name file -ErrorAction Ignore) {
    $mimeType = "$(file --brief --dereference --mime-type -- $Path)"
} else {
    Write-Host "❌ Do you have 'GNU file' installed?"
    exit 1
}

if ($mimeType -eq 'inode/x-empty') {
    Write-Host "Empty file" -BackgroundColor White -ForegroundColor Black
    exit 0
}

if ($Host.UI.RawUI.WindowSize.Height -gt 5) {
    Write-Host "📊 Information:"
    Write-Host " - Name: '$($item.Name)'"
    Write-Host " - Size: $([math]::Round($item.Length/1KB, 2)) KB"
    Write-Host " - MIME-type: $mimeType"
    Write-Host "🎯 Content:"
}

if ($mimeType -like 'text/*' -or $mimeType -like 'application/json*' -or $mimeType -like 'application/xml*') {
    if (Get-Command -Name bat -ErrorAction Ignore) {
        bat --style=numbers --color=always --pager=never --highlight-line=0 -- "$Path"
    } else {
        Get-Content -Path $Path -TotalCount 50 | ForEach-Object {
            $line = $_
            if ($line.Length -gt 120) {
                $line.Substring(0, 117) + "..."
            } else {
                $line
            }
        }
    }
    Write-Host "..."
} elseif ($mimeType -like 'image/*' -or $mimeType -like 'video/*') {
    if (Get-Command -Name chafa -ErrorAction Ignore) {
        chafa --size=$(
            if ($Host.UI.RawUI.WindowSize.Width)
                { $Host.UI.RawUI.WindowSize.Width - 3 }
            else
                { 60 }
        ) "$Path"
    } else {
        Write-Host "❌ Do you have 'chafa' installed?"
        if (Get-Command -Name file -Ignore) { file $Path }
    }
} elseif ($mimeType -like 'application/*zip*' -or $mimeType -like 'application/*rar*') {
    if (Get-Command -Name 7z -ErrorAction Ignore) {
        Write-Host "📦 Archive content:"
        7z l "$Path" | Select-Object -First 50
        Write-Host "..."
    } else {
        Write-Host "❌ Do you have '7zip' installed?"
        if (Get-Command -Name file -Ignore) { file $Path }
    }
} else {
    if (Get-Command -Name file -ErrorAction Ignore) { file $Path }
    if (Get-Command -Name strings -ErrorAction Ignore) {
        Write-Host "🔢 HEX:"
        strings $Path | Select-Object -First 50
        Write-Host "..."
    }
}
