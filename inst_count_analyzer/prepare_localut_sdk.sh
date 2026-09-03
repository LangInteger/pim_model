#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDK_INPUT=${1:?usage: prepare_localut_sdk.sh /path/to/upmem-2023.2.0-Linux-x86_64 [compat-dir]}

if [[ ! -d "$SDK_INPUT" ]]; then
  echo "SDK directory does not exist: $SDK_INPUT" >&2
  exit 2
fi
SDK="$(cd "$SDK_INPUT" && pwd -P)"

COMPAT_INPUT=${2:-$SCRIPT_DIR/.work/sdk_compat}
COMPAT_DIR="$(python3 -c 'import os, sys; print(os.path.realpath(sys.argv[1]))' "$COMPAT_INPUT")"
case "$COMPAT_DIR" in
  "$SDK"|"$SDK"/*)
    echo "Compatibility directory must be outside the read-only SDK: $COMPAT_DIR" >&2
    exit 2
    ;;
esac
mkdir -p "$COMPAT_DIR"

if [[ ! -x "$SDK/bin/clang" ]]; then
  echo "SDK compiler is not executable: $SDK/bin/clang" >&2
  echo "Refusing to chmod the read-only SDK dependency." >&2
  exit 2
fi

# LoCaLUT archives may omit compatibility SONAME links. Generate them only in
# analyzer-owned storage and point them at the read-only SDK libraries.
for library in libdpuverbose libdpuvpd libdpuhw; do
  target="$SDK/lib/$library.so.2023.2"
  if [[ ! -e "$target" ]]; then
    echo "Required SDK library does not exist: $target" >&2
    exit 2
  fi
  ln -sfn "$target" "$COMPAT_DIR/$library.so.0.0"
done

COMPAT_LD_LIBRARY_PATH="$COMPAT_DIR:$SDK/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# Newer Linux distributions may only provide libtinfo.so.6. Build the minimal
# compatibility library beside the SONAME links, never inside the SDK.
if ! env LD_LIBRARY_PATH="$COMPAT_LD_LIBRARY_PATH" \
  "$SDK/bin/clang" --version >/dev/null 2>&1; then
  cat > "$COMPAT_DIR/tinfo5_compat.c" <<'EOF'
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
typedef int (*setupterm_fn)(char*, int, int*); typedef void* (*set_curterm_fn)(void*);
typedef int (*del_curterm_fn)(void*); typedef int (*tigetnum_fn)(char*); static void *h;
static void e(void){if(!h){h=dlopen("libtinfo.so.6",RTLD_LAZY|RTLD_LOCAL);if(!h){fprintf(stderr,"%s\n",dlerror());abort();}}}
int setupterm(char*a,int b,int*c){e();return ((setupterm_fn)dlsym(h,"setupterm"))(a,b,c);} void*set_curterm(void*a){e();return ((set_curterm_fn)dlsym(h,"set_curterm"))(a);} int del_curterm(void*a){e();return ((del_curterm_fn)dlsym(h,"del_curterm"))(a);} int tigetnum(char*a){e();return ((tigetnum_fn)dlsym(h,"tigetnum"))(a);}
EOF
  cat > "$COMPAT_DIR/tinfo5.map" <<'EOF'
NCURSES_TINFO_5.0.19991023 { global: setupterm; set_curterm; del_curterm; tigetnum; local: *; };
EOF
  cc -shared -fPIC "$COMPAT_DIR/tinfo5_compat.c" \
    -Wl,--version-script="$COMPAT_DIR/tinfo5.map" \
    -Wl,-soname,libtinfo.so.5 -ldl -o "$COMPAT_DIR/libtinfo.so.5"
fi

if ! env LD_LIBRARY_PATH="$COMPAT_LD_LIBRARY_PATH" \
  "$SDK/bin/clang" --version >/dev/null 2>&1; then
  echo "UPMEM clang still cannot run after preparing compatibility files in $COMPAT_DIR" >&2
  exit 2
fi

cat > "$COMPAT_DIR/upmem_env.sh" <<EOF
export UPMEM_HOME="$SDK"
export PATH="$SDK/bin:\$PATH"
export LD_LIBRARY_PATH="$COMPAT_DIR:$SDK/lib\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}"
export UPMEM_NO_OS_WARNING=1
EOF

echo "source $COMPAT_DIR/upmem_env.sh"
