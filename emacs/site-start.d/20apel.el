;;; 50apel.el --- Debian apel startup file  -*-mode: emacs-lisp;-*-

(let* ((pkg "apel")
       (flavor-name (if (boundp 'debian-emacs-flavor)
			(symbol-name debian-emacs-flavor)
		      "emacs"))
       (pkg-inst (concat "/usr/lib/emacsen-common/packages/install/" pkg))
       (elc-dir (concat "/usr/share/" flavor-name "/site-lisp/" pkg)))
  (when (and (file-exists-p elc-dir)
	     (file-exists-p pkg-inst))
    (when (and (not (featurep 'mule))
	       (file-exists-p (concat elc-dir "/nomule")))
      (setq elc-dir (concat elc-dir "/nomule")))
    (if (fboundp 'debian-pkg-add-load-path-item)
	(debian-pkg-add-load-path-item elc-dir)
      (setq load-path (cons elc-dir load-path)))
    ;;
    ))

;;; 50apel.el ends here
