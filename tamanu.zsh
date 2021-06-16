alias ctam="cd $TAMANU_ROOT"

function tam() {
  # Windows terminal
  cmd.exe /c "wt.exe" \
    -p "Command Prompt" \
    cmd /k "adb kill-server & adb -a nodaemon server start"

  # WSL terminal
  cd "$TAMANU_ROOT/tamanu-mobile"
  socat -d -d TCP-LISTEN:5037,reuseaddr,fork TCP:$(cat /etc/resolv.conf |
    tail -n1 |
    cut -d " " -f 2):5037 \
    ;
  yarn android
  yarn start --host 127.0.0.1
}
