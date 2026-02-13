;;; mod-vc.el --- version control -*- lexical-binding: t; -*-

(use-package magit
  :commands (magit-status)
  :bind ("C-x g" . magit-status))

(use-package forge
  :after magit)

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(provide 'mod-vc)
