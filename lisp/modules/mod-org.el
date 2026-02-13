;;; mod-org.el --- org and org-roam setup -*- lexical-binding: t; -*-

(use-package org
:ensure nil
:config
(setq org-directory "~/org"))

(use-package org-roam
:after org
:custom
(org-roam-completion-everywhere t)
:bind
(:map org-mode-map
("C-c n f" . org-roam-node-find)
("C-c n i" . org-roam-node-insert)
("C-c n l" . org-roam-buffer-toggle))
:config
(org-roam-db-autosync-mode))

(use-package org-roam-ui
:after org-roam
:custom
(org-roam-ui-open-on-start t)
:commands org-roam-ui-mode)

(provide 'mod-org)
