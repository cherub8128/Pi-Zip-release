# Pi Zip

![Pi Zip](assets/icon.png)

빠르고 작고 안전한 압축 프로그램입니다. 자체 코덱과 `.piz` 형식으로 7-Zip보다 작게 묶고, ZIP·7z·RAR·tar 등 널리 쓰이는 형식을 안전하게 풉니다. 개인·교육·업무용으로 무료 사용할 수 있습니다.

[최신 버전 다운로드](https://github.com/cherub8128/Pi-Zip-release/releases/latest) · [Pi-Dimension](https://pi-dimension.com)

- 자체 코덱: 최적 파싱 LZ + 문맥 모델 산술 부호, 로지스틱 혼합(레벨 8·9), BWT와 비교해 짧은 쪽 선택
- 이미 압축된 파일도 한 번 더: JPEG, PNG, PDF, ZIP 계열(docx·xlsx·jar), gzip 안의 Deflate를 되살려 다시 압축하고, 원본과 바이트 단위로 같은지 확인한 뒤에만 씁니다
- 아카이브 전체 중복 제거, 비슷한 파일끼리 모으는 배치, 모든 코어를 쓰는 병렬 압축·해제
- 압축 중에도 다른 일이 느려지지 않도록 낮은 우선순위로 쉬는 코어만 사용(설정의 'CPU 사용')
- 비밀번호: Argon2id + XChaCha20-Poly1305, 파일 이름까지 암호화
- 복구 레코드(리드-솔로몬)로 일부 손상된 아카이브 되살리기
- 풀 때 위험한 경로·압축 폭탄을 막고, 기본은 덮어쓰지 않음
- 읽기: .piz, ZIP, 7z, RAR(5.0·2.9~4.x, 자체 해제기), tar, gz, bz2, xz, zst, lz4 · 쓰기: RAR을 뺀 모두
- Noto Sans 글꼴 내장, 밝은·어두운 화면

## 얼마나 작고 빠른가요?

소스·문서·라이브러리·이미지가 섞인 폴더(323 MiB, 파일 4,200개)를 4코어 컴퓨터에서 같은 조건으로 잰 값입니다.

| | 크기 | 묶기 | 풀기 |
| --- | --- | --- | --- |
| Pi Zip 레벨 5 | 23.57% | 13.0초 | 4.0초 |
| **Pi Zip 레벨 7 (기본)** | **17.95%** | 77.9초 | 5.3초 |
| Pi Zip 레벨 8 | **16.77%** | 102.0초 | 7.7초 |
| Pi Zip 레벨 9 | **16.48%** | 126.5초 | 20.2초 |
| 7-Zip 보통(mx5) | 19.13% | 57.8초 | 3.7~4.4초 |
| 7-Zip 최고(mx9) | 17.12% | 112.1초 | 6.3초 |

크기는 원본 대비 비율이며 작을수록 좋습니다. 기본 레벨 7은 7-Zip 보통보다 6%, 레벨 8은 7-Zip 최고보다 2%, 레벨 9는 3.7% 작습니다.

## 어떤 파일을 받으면 되나요?

| 기기 | 선택할 파일 |
| --- | --- |
| Windows 10·11 64비트 | `windows-x64-setup.exe` 권장 · MSI가 필요하면 `windows-x64.msi` · 설치 없이 쓰려면 `windows-x64-portable.exe` |
| Ubuntu·Debian 계열 64비트 | `linux-x64.deb` |
| Fedora·openSUSE 등 RPM 계열 64비트 | `linux-x64.rpm` |
| Linux 64비트, 설치 없이 실행 | `linux-x64.AppImage` — 파일 실행 권한을 허용한 뒤 열기 |
| 그 외 Linux 64비트 | `linux-x64.tar.gz` — 압축 안의 `README.txt` 참고 |
| Mac (Apple Silicon·Intel 모두) | `mac-universal.dmg` · 또는 `mac-universal-adhoc.zip` |
| Android 7.0 이상 | `android.apk` |

Windows 설치 파일은 관리자 권한 없이 사용자 계정에 설치되며, .piz·zip·7z·rar·tar 등을 Pi Zip으로 열 수 있게 연결합니다. 연결 프로그램은 Windows의 **연결 프로그램** 설정에서 바꿀 수 있습니다.

Mac·Linux·Android 버전은 시험 배포이며 해당 운영체제의 실행 확인이 아직 끝나지 않았습니다. Windows·Mac에서 개발자 확인 안내가 나타날 수 있으며, Mac 버전은 Apple 공증을 받지 않았습니다. Mac에서 "손상되었기 때문에 열 수 없습니다"가 나오면 앱을 응용 프로그램 폴더로 옮긴 뒤 터미널에서 `xattr -dr com.apple.quarantine "/Applications/Pi Zip.app"`을 실행하세요.

Linux 버전은 WebKitGTK 4.1(`libwebkit2gtk-4.1-0`)과 GTK 3이 필요합니다. deb·rpm은 설치할 때 함께 설치합니다. AppImage의 일반 실행에는 FUSE와 fusermount가 필요합니다. FUSE를 사용할 수 없다면 `./Pi-Zip-0.12.1-linux-x64.AppImage --appimage-extract-and-run`으로 실행할 수 있습니다.

Android에서는 **압축 파일 열기**나 **파일 묶기**로 파일을 고르세요. 결과는 **다운로드/Pi Zip** 폴더에 저장합니다(Android 10 이하에서는 앱 전용 폴더). 폴더 통째로 묶기와 저장 위치 고르기는 Android에서 지원하지 않습니다.

## 이용 안내

개인·교육·회사·기관의 업무용 사용과 조직 내부 설치를 무료로 허용합니다. 앱의 판매·외부 재배포는 제한됩니다. Pi Zip으로 만든 아카이브는 자유롭게 보관·전송·배포할 수 있습니다. 자세한 조건은 [이용약관](LICENSE.txt), 포함된 오픈소스와 글꼴의 조건은 [라이선스 고지](THIRD_PARTY_NOTICES.md)와 [licenses](licenses/)를 확인하세요.

[Pi-Dimension](https://pi-dimension.com)
