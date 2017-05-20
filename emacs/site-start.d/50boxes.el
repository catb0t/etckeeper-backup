;;; 50boxes.el -- debian emacs setups for boxes

(if (not (file-exists-p "/usr/share/emacs/site-lisp/boxes.el"))
    (message "boxes removed but not purged, skipping setup")

  ;; These autoloads as recommended by comments at the start of boxes.el.
  ;; The code has some more autoload cookies but don't think they're needed
  ;; for normal operation.
  (autoload 'boxes-command-on-region "boxes" nil t)
  (autoload 'boxes-remove "boxes" nil t)
  (autoload 'boxes-create "boxes" nil t))
