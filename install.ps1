# Pi Zip 명령줄 도구 `piz` 설치 (Windows x64/arm64, 관리자 권한 필요 없음)
#   irm https://raw.githubusercontent.com/cherub8128/Pi-Zip-release/main/install.ps1 | iex
# 설치 위치: %LOCALAPPDATA%\Programs\piz (사용자 PATH에 더한다)
$ErrorActionPreference = 'Stop'
$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'x64' }
$url = "https://github.com/cherub8128/Pi-Zip-release/releases/latest/download/piz-windows-$arch.zip"
$dir = Join-Path $env:LOCALAPPDATA 'Programs\piz'
$tmp = Join-Path ([IO.Path]::GetTempPath()) ("piz-" + [guid]::NewGuid())
New-Item -ItemType Directory -Force -Path $dir, $tmp | Out-Null
Write-Host "받는 중: $url"
Invoke-WebRequest $url -OutFile "$tmp\piz.zip" -UseBasicParsing
Expand-Archive "$tmp\piz.zip" -DestinationPath $tmp -Force
Copy-Item "$tmp\piz.exe" $dir -Force
Remove-Item $tmp -Recurse -Force
$path = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($path -split ';') -notcontains $dir) {
  [Environment]::SetEnvironmentVariable('Path', ($path.TrimEnd(';') + ";$dir").TrimStart(';'), 'User')
  $env:Path += ";$dir"
  Write-Host "사용자 PATH에 $dir 를 더했습니다(새 터미널부터 적용)."
}
& "$dir\piz.exe" --version
