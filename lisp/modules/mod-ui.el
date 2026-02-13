;;; mod-ui.el --- UI configuration -*- lexical-binding: t; -*-

(setq modus-themes-bold-constructs t
modus-themes-italic-constructs t)

(defun my/load-appropriate-modus-theme ()
(let* ((hour (string-to-number (format-time-string "%H")))
(dark-p (or (>= hour 18) (< hour 7))))
(mapc #'disable-theme custom-enabled-themes)
(load-theme (if dark-p
'modus-vivendi
'modus-operandi)
t)))

(my/load-appropriate-modus-theme)
(run-at-time "1 hour" 3600 #'my/load-appropriate-modus-theme)

(provide 'mod-ui)
