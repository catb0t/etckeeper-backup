;; -*-emacs-lisp-*-
;;
;; Emacs startup file for the Debian GNU/Linux elserv package
;;
;; Originally contributed by Nils Naumann <naumann@unileoben.ac.at>
;; Modified by Dirk Eddelbuettel <edd@debian.org>
;; Adapted for dh-make by Jim Van Zandt <jrv@vanzandt.mv.com>

;; The elserv package follows the Debian/GNU Linux 'emacsen' policy and
;; byte-compiles its elisp files for each 'emacs flavor' (emacs19,
;; xemacs19, emacs20, xemacs20...).  The compiled code is then
;; installed in a subdirectory of the respective site-lisp directory.
;; We have to add this to the load-path:

(when (featurep 'mule)
  (if (not (file-exists-p "/usr/share/emacs/site-lisp/elserv"))
      (message "Package elserv removed but not purged.  Skipping setup.")
    (debian-pkg-add-load-path-item
     (concat "/usr/share/" (symbol-name debian-emacs-flavor)
	     "/site-lisp/elserv"))

    (autoload 'elserv-start "elserv" nil t)
    (autoload 'elserv-mhc-start "es-mhc" nil t)
    (autoload 'elserv-demo-start "es-demo" nil t)
    (autoload 'elserv-wiki-start "es-wiki" nil t)
    (autoload 'remote-controller "remote" nil t)
    (autoload 'web-custom "web-custom" nil t)
    (setq elserv-daemon-name "/usr/lib/elserv/elservd")
    (setq elserv-icon-path "/usr/share/elserv/icons")))
