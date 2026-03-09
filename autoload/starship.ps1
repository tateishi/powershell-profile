$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"

# --- Windows 10 / 11 の判定 & 表示用の環境変数設定 ---

try {
    $cvPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
    $cv = Get-ItemProperty -Path $cvPath
    $build = [int]$cv.CurrentBuildNumber
    $name = $cv.ProductName          # 例: "Windows 11 Pro", "Windows 10 Pro"
    $dispVer = $cv.DisplayVersion       # 例: "23H2"（Windows 10/11 で共通的に使われる）
    if (-not $dispVer) { $dispVer = $cv.ReleaseId }  # 古い 10 の場合のフォールバック

    if ($build -ge 22000) {
        $env:STARSHIP_WINDOWS_FAMILY = '11'
    }
    else {
        $env:STARSHIP_WINDOWS_FAMILY = '10'
    }

    # 併せて詳細も入れておくと便利（任意）
    $env:STARSHIP_WINDOWS_NAME = $name           # 例: "Windows 11 Pro"
    $env:STARSHIP_WINDOWS_BUILD = "$build"        # 例: "22631"
    $env:STARSHIP_WINDOWS_VER = $dispVer        # 例: "23H2"
}
catch {
    # 失敗時は一旦不明扱い
    $env:STARSHIP_WINDOWS_FAMILY = 'Windows'
}

# 起動した PowerShell のバージョンを Starship 用の環境変数に書き出す
$Env:STARSHIP_POWERSHELL_VERSION = $PSVersionTable.PSVersion.ToString()

# （任意）見分けやすいように種別も出す
if ($PSVersionTable.PSEdition -eq 'Core') {
    $Env:STARSHIP_POWERSHELL_KIND = 'ps7'
}
else {
    $Env:STARSHIP_POWERSHELL_KIND = 'ps5'
}

Invoke-Expression (&starship init powershell)
