# Exports the QT_PRINTER_MODULE from the qtubuntu-print package

case $XDG_SESSION_DESKTOP in
  ubuntu-touch|unity8*)
    export QT_PRINTER_MODULE=qtubuntu-print
    ;;
esac
