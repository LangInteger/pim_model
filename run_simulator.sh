SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

cd "$SCRIPT_DIR"/uPIMulator/golang/uPIMulator/script \
&& python3 build.py \
&& cd "$SCRIPT_DIR"/uPIMulator/golang/uPIMulator \
&& bash ./batch_run.sh