#!/bin/sh
# Pi Zip 명령줄 도구 `piz` 설치 (Linux x64/arm64, macOS)
#   curl -fsSL https://raw.githubusercontent.com/cherub8128/Pi-Zip-release/main/install.sh | sh
# 설치 위치: $PIZ_INSTALL_DIR, 없으면 쓸 수 있을 때 /usr/local/bin, 아니면 ~/.local/bin
set -eu
REPO=cherub8128/Pi-Zip-release
case "$(uname -s)" in
  Linux)
    case "$(uname -m)" in
      x86_64 | amd64) P=linux-x64 ;;
      aarch64 | arm64) P=linux-arm64 ;;
      *) echo "지원하지 않는 CPU: $(uname -m)" >&2; exit 1 ;;
    esac ;;
  Darwin) P=mac-universal ;;
  *) echo "지원하지 않는 OS: $(uname -s) (Windows는 install.ps1)" >&2; exit 1 ;;
esac
URL="https://github.com/$REPO/releases/latest/download/piz-$P.tar.gz"
if [ -n "${PIZ_INSTALL_DIR:-}" ]; then DIR=$PIZ_INSTALL_DIR
elif [ -w /usr/local/bin ]; then DIR=/usr/local/bin
else DIR=$HOME/.local/bin; fi
mkdir -p "$DIR"
TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
echo "받는 중: $URL"
if command -v curl >/dev/null 2>&1; then curl -fsSL "$URL" -o "$TMP/piz.tgz"; else wget -qO "$TMP/piz.tgz" "$URL"; fi
tar -xzf "$TMP/piz.tgz" -C "$TMP"
install -m 755 "$TMP/piz" "$DIR/piz"
echo "설치했습니다: $DIR/piz ($("$DIR/piz" --version))"
case ":$PATH:" in *":$DIR:"*) ;; *) echo "PATH에 $DIR 를 더하세요: export PATH=\"$DIR:\$PATH\"" ;; esac
