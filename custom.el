;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((eval setq org-roam-db-location
	   (expand-file-name "org-roam.db"
			     (locate-dominating-file default-directory
						     ".dir-locals.el")))
     (eval setq org-roam-directory
	   (expand-file-name "org-roam"
			     (locate-dominating-file default-directory
						     ".dir-locals.el")))
     (org-roam-db-location . "org-roam.db")
     (org-roam-directory . "org-roam")
     (org-roam-db-location . "./org-roam.db")
     (org-roam-directory . "./org-roam"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
