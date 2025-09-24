try {
    # Sử dụng TLS 1.2 cho kết nối HTTPS
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {}

# Đặt URL tải file
$url = 'https://drhoangzp.github.io/x.cmd'

# Tạo tên file ngẫu nhiên trong thư mục TEMP
$rand = [guid]::NewGuid().ToString()
$tempPath = Join-Path $env:TEMP "x_$rand.cmd"

# Tải file
try {
    Invoke-WebRequest -Uri $url -OutFile $tempPath -ErrorAction Stop
#    Write-Host "Tai file thanh cong: $tempPath"
} catch {
    Write-Error "Khong the tai file từ $url"
    return
}

# Kiểm tra file đã được tạo chưa
if (-not (Test-Path $tempPath)) {
    Write-Error "File khong ton tai sau khi tai ve. Dung lai."
    return
}

# Thực thi file với quyền admin

try {
# Nếu không muốn chuyển admin thì thay Start-Process -FilePath "cmd.exe" ... thì thay thành & cmd.exe /c "`"$tempPath`""
#    & cmd.exe /c "`"$tempPath`""
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$tempPath`"" -Verb RunAs -Wait
} catch {
    Write-Error "Khong the thuc thi file: $($_.Exception.Message)"
    return
}

# Xoá file sau khi thực thi xong
try {
    Remove-Item $tempPath -Force
#    Write-Host "Đã xoá file: $tempPath"
} catch {
    Write-Warning "Khong the xoa file: $($_.Exception.Message)"
}


