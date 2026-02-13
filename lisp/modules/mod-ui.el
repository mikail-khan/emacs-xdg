;;; mod-ui.el --- UI configuration -*- lexical-binding: t; -*-

;;;; Modus configuration (must be set BEFORE theme loads)

(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-mixed-fonts nil
      modus-themes-variable-pitch-ui nil
      modus-themes-org-blocks 'tinted-background
      modus-themes-completions '((matches . (bold))
                                 (selection . (accented))
                                 (popup . (accented))))

;;;; Theme logic

(defun my/current-hour ()
  "Return current hour as integer."
  (string-to-number (format-time-string "%H")))

(defun my/should-use-dark-theme-p ()
  "Return non-nil if dark theme should be active."
  (let ((hour (my/current-hour)))
    (or (>= hour 17) (< hour 7))))

(defun my/desired-modus-theme ()
  "Return the correct Modus tinted theme symbol."
  (if (my/should-use-dark-theme-p)
      'modus-vivendi-tinted
    'modus-operandi-tinted))

(defun my/load-appropriate-modus-theme ()
  "Load the appropriate Modus tinted theme if not already active."
  (let ((desired (my/desired-modus-theme)))
    (unless (eq (car custom-enabled-themes) desired)
      (mapc #'disable-theme custom-enabled-themes)
      (load-theme desired t))))

;;;; Manual toggle

(defun my/toggle-modus-theme ()
  "Toggle between Modus tinted light and dark themes."
  (interactive)
  (let ((next (if (eq (car custom-enabled-themes)
                      'modus-vivendi-tinted)
                  'modus-operandi-tinted
                'modus-vivendi-tinted)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme next t)))

;;;; Initialize

;; Load correct theme at startup
(my/load-appropriate-modus-theme)

;; Re-check every hour
(run-at-time "1 hour" 3600 #'my/load-appropriate-modus-theme)

;; Optional keybinding for manual toggle
(global-set-key (kbd "C-c t") #'my/toggle-modus-theme)

(provide 'mod-ui)
