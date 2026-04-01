;;; mod-eglot.el --- LSP configuration -*- lexical-binding: t; -*-

(use-package eglot
  :ensure nil
  :hook (prog-mode . eglot-ensure)
  :commands (eglot eglot-ensure)
  :config

  ;; -----------------------------
  ;; Python → basedpyright
  ;; Supports python-mode + python-ts-mode
  ;; -----------------------------
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode)
                 . ("basedpyright-langserver" "--stdio")))

  ;; -----------------------------
  ;; Performance / behavior tuning
  ;; -----------------------------
  (setq eglot-autoshutdown t
        eglot-sync-connect nil
        eglot-extend-to-xref t
        eglot-events-buffer-size 0
        eglot-report-progress nil

        ;; Allow eglot outside project.el projects
        eglot-ensure-project nil))

(provide 'mod-eglot)
