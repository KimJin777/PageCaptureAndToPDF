#!/usr/bin/env pwsh
# 설치 스크립트 (Windows PowerShell)
# 1) Python 패키지 설치
Write-Host "== Python 패키지 설치: requirements.txt =="
python -m pip install --upgrade pip
python -m pip install -r .\requirements.txt

# 2) Tesseract 설치 여부 확인
Write-Host "\n== Tesseract 설치 확인 =="
try {
    $t = Get-Command tesseract -ErrorAction Stop
    Write-Host "Tesseract가 설치되어 있습니다: $($t.Path)"
} catch {
    Write-Host "Tesseract가 감지되지 않았습니다." -ForegroundColor Yellow
    Write-Host "수동 설치 안내: https://github.com/tesseract-ocr/tesseract/releases"
    Write-Host "또는 Chocolatey가 설치된 경우 관리자 PowerShell에서: choco install tesseract -y"
}

Write-Host "\n설치 스크립트 완료. 노트북의 TESSERACT_PATH를 확인하세요."
