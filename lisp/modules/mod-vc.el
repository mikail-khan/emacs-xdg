;;; mod-vc.el --- version control -*- lexical-binding: t; -*-

(use-package magit
:commands (magit-status)
:bind ("C-x g" . magit-status))

(provide 'mod-vc)
