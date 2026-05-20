# 설치 안내 (간단)

프로젝트에서 필요한 설치 항목과 실행 방법을 정리합니다.

- **필수 Python 패키지**: 프로젝트 루트의 `requirements.txt`에 목록화되어 있습니다.
- **Tesseract OCR 프로그램**: `pytesseract`는 Tesseract 실행파일이 필요합니다. Windows 기본 경로 예: `C:\Program Files\Tesseract-OCR\tesseract.exe`.

빠른 설치 방법 (Windows):

1. PowerShell을 열고 프로젝트 폴더로 이동합니다.

이 README 파일이 있는 폴더(프로젝트의 `capturePage` 폴더)에서 아래 명령을 실행하세요.

```powershell
# (옵션 A) 리포지토리 루트에서 실행할 경우
cd capturePage
powershell -ExecutionPolicy Bypass -File .\install.ps1

# (옵션 B) 이미 이 폴더에서 실행하는 경우
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

2. Tesseract가 설치되어 있지 않다면 아래에서 설치하세요:

- 공식 릴리스: https://github.com/tesseract-ocr/tesseract/releases
- Chocolatey 사용: `choco install tesseract -y` (관리자 권한 필요)

3. 노트북(`toPDF.ipynb`)에서 `TESSERACT_PATH` 변수를 실제 경로로 설정하세요. 예:

```python
TESSERACT_PATH = r"C:\Program Files\Tesseract-OCR\tesseract.exe"
pytesseract.pytesseract.tesseract_cmd = TESSERACT_PATH
```

파일 요약:

- requirements.txt: Python 패키지 목록
- install.ps1: 윈도우용 설치 스크립트 (pip 설치 및 Tesseract 확인)
- README.md: 이 파일

실행 순서 (권장)

1) 페이지 캡처
- VS Code 또는 Jupyter에서 `importPage.ipynb`를 엽니다.
- `capture_all_pages_with_clean_name(total_pages=...)` 호출부분의 `total_pages` 값을 캡처할 페이지 수로 수정합니다.
- 오른쪽 모니터의 대상 웹페이지에 포커스를 맞춘 뒤 노트북의 해당 셀(또는 전체)을 실행합니다.
- 캡처 결과는 `captured_YYYYMMDD_HHMMSS` 형태의 새 폴더에 `001.jpg`, `002.jpg` 순서로 저장됩니다.

참고: 자동 키보드/마우스 조작을 사용하는 `pyautogui`는 실행 시 관리자 권한 또는 보안 설정(Windows의 경우 사용자 계정 컨트롤)을 요구할 수 있습니다. 캡처 도중 마우스/키보드를 건드리지 마세요.

2) PDF 변환
- `toPDF.ipynb`를 열고, `TESSERACT_PATH`가 실제 Tesseract 설치 경로로 설정되어 있는지 확인하세요.
- `TARGET_FOLDER` 변수에 1)에서 생성된 캡처 폴더명을 지정합니다. 예: `TARGET_FOLDER = r"./captured_20260520_094500"`
- `OUTPUT_FILE`에 결과 PDF 파일명을 지정한 뒤 셀을 실행하면 OCR이 적용된 PDF가 생성됩니다.

명령어 예시 (노트북 대신 스크립트로 실행할 때)

```powershell
# 설치 후 (프로젝트 루트)
python -m pip install -r .\requirements.txt

# 1) (옵션) importPage 노트북을 스크립트로 실행(또는 노트북에서 실행)
jupyter nbconvert --to script importPage.ipynb
python importPage.py

# 2) toPDF 실행
jupyter nbconvert --to script toPDF.ipynb
python toPDF.py
```

GitHub에 업로드 할 때 주의사항

- 프로젝트 파일(코드, 스크립트, README 등)은 저장소에 올리되, 프로그램으로 생성되는 이미지 폴더(`captured_*`)와 생성된 PDF 파일은 업로드하지 않도록 `.gitignore`를 설정했습니다.
- 로컬에서 원격 저장소로 업로드하려면 제공된 `upload.ps1` 스크립트를 사용하면 됩니다. 예:

```powershell
# 현재 디렉토리가 capturePage일 때
.\upload.ps1
```

스크립트는 `.gitignore`에 따라 생성된 파일들을 제외하고 커밋/푸시합니다. 푸시 시 Git 인증(토큰 또는 계정)이 필요합니다.
