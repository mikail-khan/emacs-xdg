;;; mod-org.el --- org and org-roam setup -*- lexical-binding: t; -*-

;; -----------------------------
;; Core Org
;; -----------------------------
(use-package org
  :ensure nil
  :custom
  (org-directory "~/org"))

;; -----------------------------
;; Org-roam
;; -----------------------------
(use-package org-roam
  :after org
  :custom
  (org-roam-directory (expand-file-name "org-roam" org-directory))
  (org-roam-completion-everywhere t)
  :bind
  (:map org-mode-map
        ("C-c n f" . org-roam-node-find)
        ("C-c n i" . org-roam-node-insert)
        ("C-c n l" . org-roam-buffer-toggle))
  :config
  (org-roam-db-autosync-mode))

;; -----------------------------
;; Org-roam UI
;; -----------------------------
(use-package org-roam-ui
  :after org-roam
  :commands org-roam-ui-mode
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t))

(provide 'mod-org)
