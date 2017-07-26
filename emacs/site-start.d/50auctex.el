;;; This is a conffile: you can edit it if you like; however,
;;; please note that if you do not want AUCTeX to override the standard
;;; Emacs TeX mode, you may unload AUCTeX completely by evaluating the
;;; form "(unload-feature 'tex-site)" (i.e., put that string into your
;;; "~/.emacs" to disable AUCTeX completely).

(if (member debian-emacs-flavor '(emacs24 emacs25 emacs-snapshot))
    (if (file-exists-p "/usr/share/emacs/site-lisp/auctex/tex.el")
	(progn
	  (let ((list '((lisp . "auctex") (source . "auctex"))))
	    (while list
	      (let ((elt (car list)))
		(cond
		 ((equal 'lisp (car elt))
		  (let ((dir (concat "/usr/share/"
				     (symbol-name debian-emacs-flavor)
				     "/site-lisp/" (cdr elt))))
		    (when (file-directory-p dir)
		      (if (fboundp 'debian-pkg-add-load-path-item)
			  (debian-pkg-add-load-path-item dir)
			(add-to-list 'load-path dir 'append)))))
		 ((equal 'source (car elt))
		  (let ((dir (concat "/usr/share/emacs/site-lisp/"
				     (cdr elt))))
		    (when (file-directory-p dir)
		      (add-to-list 'load-path dir 'append))))))
	      (setq list (cdr list))))
	  (load "auctex.el")
	  (load "preview-latex.el"))
      (message "auctex: Package removed but not purged; skipping setup")))
