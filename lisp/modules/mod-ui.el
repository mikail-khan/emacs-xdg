;;; mod-ui.el --- UI configuration -*- lexical-binding: t; -*-

;; Modus configuration (set before loading a theme).
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-mixed-fonts nil
      modus-themes-variable-pitch-ui nil
      modus-themes-org-blocks 'tinted-background
      modus-themes-completions '((matches . (bold))
                                 (selection . (accented))
                                 (popup . (accented))))

(defun my/current-hour ()
  "Return current hour as an integer."
  (string-to-number (format-time-string "%H")))

(defun my/should-use-dark-theme-p ()
  "Return non-nil when the dark theme should be active."
  (let ((hour (my/current-hour)))
    (or (>= hour 17) (< hour 7))))

(defun my/desired-modus-theme ()
  "Return the Modus theme appropriate for the current time."
  (if (my/should-use-dark-theme-p)
      'modus-vivendi-tinted
    'modus-operandi-deuteranopia))

(defun my/load-appropriate-modus-theme ()
  "Load the time-appropriate Modus theme unless it is already active."
  (let ((desired (my/desired-modus-theme)))
    (unless (memq desired custom-enabled-themes)
      (mapc #'disable-theme custom-enabled-themes)
      (load-theme desired t))))

(defun my/toggle-modus-theme ()
  "Temporarily toggle between the configured light and dark Modus themes.

The scheduled theme check may restore the time-appropriate theme later."
  (interactive)
  (let ((next (if (memq 'modus-vivendi-tinted custom-enabled-themes)
                  'modus-operandi-deuteranopia
                'modus-vivendi-tinted)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme next t)))

(my/load-appropriate-modus-theme)

;; Re-check once per hour.  A manual toggle is therefore temporary.
(run-at-time "1 hour" 3600 #'my/load-appropriate-modus-theme)

(keymap-global-set "C-c t" #'my/toggle-modus-theme)

(provide 'mod-ui)
