;-*-emacs-lisp-*-
; arch-tag: 045640fd-0ff2-45b7-a29f-68e4b8378fbf

(let ((package-dir (concat "/usr/share/"
                           (symbol-name debian-emacs-flavor)
                           "/site-lisp/vm")))
  ;; If package-dir does not exist, the vm package must have
  ;; removed but not purged, and we should skip the setup.
  (when (file-directory-p package-dir)
    ;;make sure we have a compiled version ...
    (if (file-readable-p (concat package-dir "/vm.elc"))
        (progn
          (provide 'vm-init)
          (require 'vm-autoload)
          ;; Fixes for Debian
          (if (fboundp 'debian-pkg-add-load-path-item)
              (setq load-path (debian-pkg-add-load-path-item package-dir))
            (setq load-path (nconc load-path (list package-dir))))
          (eval-after-load 'vm-vars
            '(setq
              vm-toolbar-pixmap-directory
              (if (string-match "'--with-gtk'\\|'--with-x-toolkit=gtk'"
                                system-configuration-options)
                  (concat (vm-pixmap-directory) "/gtk")
                (vm-pixmap-directory))))
          (autoload (quote vm-decode-postponed-mime-message) "vm-pine" "\
Replace the mime buttons by attachment buttons.
\(fn)" t nil)

      ;; Uncomment these if you have the package mime-codecs installed
      ;; (setq
      ;;  vm-mime-qp-decoder-program "qp-decode"
      ;;  vm-mime-qp-encoder-program "qp-encode"
      ;;  vm-mime-base64-decoder-program "base64-decode"
      ;;  vm-mime-base64-encoder-program "base64-encode"
      ;;  )

      ;; If you have metamail, you would set these instead:
      ;;     (setq vm-mime-base64-decoder-program "mimencode")
      ;;     (setq vm-mime-base64-decoder-switches '("-u" "-b" "-p"))
      ;;     (setq vm-mime-base64-encoder-program "mimencode")
      ;;     (setq vm-mime-base64-encoder-switches '("-b"))
      ;;     (setq vm-mime-qp-decoder-program "mimencode")
      ;;     (setq vm-mime-qp-decoder-switches '("-u" "-q"))
      ;;     (setq vm-mime-qp-encoder-program "mimencode")
      ;;     (setq vm-mime-qp-encoder-switches '("-q"))
      ))))
