;;; 50mhc.el --- Debian mhc startup file  -*-mode: emacs-lisp;-*-

(let* ((pkg "mhc")
       (flavor-name (if (boundp 'debian-emacs-flavor)
			(symbol-name debian-emacs-flavor)
		      "emacs"))
       (pkg-inst (concat "/usr/lib/emacsen-common/packages/install/" pkg))
       (elc-dir (concat "/usr/share/" flavor-name "/site-lisp/" pkg)))
  (when (and (file-exists-p elc-dir)
	     (file-exists-p pkg-inst)
	     (featurep 'mule))
    (if (fboundp 'debian-pkg-add-load-path-item)
	(debian-pkg-add-load-path-item elc-dir)
      (setq load-path (cons elc-dir load-path)))
    (autoload 'mhc "mhc" "Message Harmonized Calendar system." t)
    ;;
    (defun mhc-select-mailer-package (mua)
      "Select mailer package for MHC: mew, gnus, wl or cmail"
      (interactive 
       (let ((mua-alist '(("mua" . mua) ("mew" . mew) ("wanderlust" . wl)
			  ("gnus" . gnus) ("cmail" . cmail))))
	 (list (cdr (assoc
		     (completing-read "Mailer Package for MHC: " mua-alist)
		     mua-alist)))))
      (setq mhc-mailer-package mua)
      (cond 
       ((eq mhc-mailer-package 'mua)
	(autoload 'mhc-setup "mhc")
	(mhc-setup))
       ((eq mhc-mailer-package 'mew)
	(autoload 'mhc-mew-setup "mhc-mew")
	(add-hook 'mew-init-hook 'mhc-mew-setup)
	(and (boundp 'mew-summary-mode-map)
	     (progn
	       (mhc-mew-setup)
	       (and (member major-mode '(mew-summary-mode mew-virtual-mode))
		    (mhc-mode)))))
       ((eq mhc-mailer-package 'wl)
	(autoload 'mhc-wl-setup "mhc-wl")
	(add-hook 'wl-init-hook 'mhc-wl-setup)
	(and (boundp 'wl-summary-mode-map)
	     (progn
	       (mhc-wl-setup)
	       (and (member major-mode '(wl-summary-mode wl-folder-mode))
		    (mhc-mode)))))
       ((eq mhc-mailer-package 'gnus)
	(autoload 'mhc-gnus-setup "mhc-gnus")
	(add-hook 'gnus-startup-hook 'mhc-gnus-setup)
	(and (boundp 'gnus-summary-mode-map)
	     (progn
	       (mhc-gnus-setup)
	       (and (member major-mode '(gnus-summary-mode gnus-group-mode))
		    (mhc-mode)))))
       ((eq mhc-mailer-package 'cmail)
	(autoload 'mhc-cmail-setup "mhc-cmail")
	(add-hook 'cmail-startup-hook 'mhc-cmail-setup)
	(and (boundp 'cmail-summary-mode-map)
	     (progn
	       (mhc-cmail-setup)
	       (and (member major-mode '(cmail-summary-mode cmail-folders-mode))
		    (mhc-mode)))))))

    (setq mhc-icon-path
	  (if (or (featurep 'xemacs) (>= emacs-major-version 21))
	      "/usr/share/pixmaps/mhc"
	    "/usr/share/pixmaps/mhc/xbm"))
    ;;
    ))

;;; 50mhc.el ends here
