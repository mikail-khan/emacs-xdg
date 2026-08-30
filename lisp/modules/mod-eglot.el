;;; mod-eglot.el --- LSP configuration -*- lexical-binding: t; -*-

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  (eglot-extend-to-xref t)
  (eglot-events-buffer-size 0)
  (eglot-report-progress nil)
  :config
  ;; Python -> basedpyright. Individual language modules decide when Eglot
  ;; starts; do not enable it for every `prog-mode' buffer.
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode)
                 . ("basedpyright-langserver" "--stdio"))))

(provide 'mod-eglot)
