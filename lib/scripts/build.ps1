param(
    [string]$Arg = '',
    [string]$Suffix = '__DEFAULT__',
    [string]$VersionSuffix = ''
)

try {
    $versionName = $null

    $versionCode = [int](git rev-list --count HEAD).Trim()

    $commitHash = (git rev-parse HEAD).Trim()

    # __DEFAULT__ 表示使用默认行为（-special-短哈希，兼容旧版调用方）
    $isDefaultSuffix = ($Suffix -eq '__DEFAULT__')

    $updatedContent = foreach ($line in (Get-Content -Path 'pubspec.yaml' -Encoding UTF8)) {
        if ($line -match '^\s*version:\s*([\d\.]+)') {
            $versionName = $matches[1]
            if ($Arg -eq 'android') {
                if ($isDefaultSuffix) {
                    # 默认行为：-短哈希（上游兼容格式）
                    $versionName += '-' + $commitHash.Substring(0, 9)
                } else {
                    # 使用传入的后缀（一般为 -短哈希，如 '-ad6c0e0d1'）
                    $versionName += $Suffix
                }
            }
            # VersionSuffix 放在 +code 之后（如 '-special-v2'）
            "version: $versionName+$versionCode$VersionSuffix"
        }
        else {
            $line
        }
    }

    if ($null -eq $versionName) {
        throw 'version not found'
    }

    $updatedContent | Set-Content -Path 'pubspec.yaml' -Encoding UTF8

    $buildTime = [int]([DateTimeOffset]::Now.ToUnixTimeSeconds())

    # 完整版本字符串（含 code 和 VersionSuffix），用于 About 页面显示
    $fullVersion = "$versionName+$versionCode$VersionSuffix"

    $data = @{
        'pili.name' = $versionName
        'pili.code' = $versionCode
        'pili.hash' = $commitHash
        'pili.time' = $buildTime
        'pili.version' = $fullVersion
    }

    $data | ConvertTo-Json -Compress | Out-File 'pili_release.json' -Encoding UTF8

    Add-Content -Path $env:GITHUB_ENV -Value "version=$fullVersion"
}
catch {
    Write-Error "Prebuild Error: $($_.Exception.Message)"
    exit 1
}